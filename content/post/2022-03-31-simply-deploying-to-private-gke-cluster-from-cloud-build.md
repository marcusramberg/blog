---
author:
  - Marcus Ramberg
draft: false
publishDate: "2022-03-31T00:00:00+02:00"
tags:
  - devops
title: Simply deploying to private GKE cluster from Cloud Build
---

I recently came back to Google's Cloud Platform after some years on other cloud platforms, and as part of my work
there I had the requirement to setup a secure GCP cluster for some workloads. Google engineers have provided a nice
blueprint for this using a [IAP Proxy Bastion host for external
access](https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/examples/safer_cluster_iap_bastion?tab=outputs),
which works well for safe access from developer machines and allows you to limit Identity Aware Proxy access by GCP
Security Groups.

Basically you establish a IAP ssh tunnel to a Tinyproxy running on the bastion host, and then
set the proxy in your kube config:

```bash
kubectl config set clusters.$context_name.proxy-url http://localhost:8888
```

Of course, we also wanted to deploy to the cluster in an automated fashion, and as Cloud Build already was the CI of
choice, I set out to reach the cluster from there. Luckily Google has somewhat recently added support for [private
worker
pools](https://globalcloudplatforms.com/2021/08/17/introducing-cloud-build-private-pools-secure-ci-cd-for-private-networks/)
so in theory this should be easy. However we hit a snag. Because the workers aren't actually running inside your VPC
and neither is the Kubernetes engine control plane, there's a restriction on transient VPC traffic. Google
Architecture Center provides a workaround using [HA VPNs and separate
VPCs](https://cloud.google.com/architecture/accessing-private-gke-clusters-with-cloud-build-private-pools), but I
found this to be a convoluted setup, and was worrying about maintaining a BGP routed VPN tunnel inside a single Google project.

After digging a bit, I found a much simpler solution. Since we already have a proxy on the Bastion host, you can
simply extend it to support traffic from the builder internal network range as well. We have to add the allowed range
to Tinyproxy in the startup script:

```terraform
%{for cidr in var.bastion_allowed_ranges}
  echo "Allow ${cidr}" >> /etc/tinyproxy/tinyproxy.conf
%{endfor}
systemctl restart tinyproxy
```

And also add a firewall policy for the provided range(s):

```terraform
resource "google_compute_firewall" "allow_bastion" {
  count   = length(var.bastion_allowed_ranges) > 0 ? 1 : 0
  name    = "allow-bastion-proxy"
  network = module.vpc.network_self_link
  project = module.enabled_google_apis.project_id
  allow {
    protocol = "tcp"
    ports    = ["8888"]
  }
  target_tags   = ["bastion"]
  source_ranges = var.bastion_allowed_ranges
}
```

Now your cloud builder will be able to reach the control plane via the proxy just by setting proxy-url like in my
first example. The reason this works is that the bastion host resides inside our VPC and thus is available directly
from our cloud build pool.
