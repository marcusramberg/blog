+++
title = "journald logs since last service restart."
author = ["Marcus Ramberg"]
date = 2020-10-30T08:29:00+01:00
publishDate = 2020-10-30T00:00:00+01:00
tags = ["devops", "unix", "systemd"]
draft = false
+++

While debugging services I often want to see the systemd service log since last restart. Unfortunately doing this isn't obvious, but there is a way.

```bash
$ journalctl _SYSTEMD_INVOCATION_ID=$(systemctl show --value -p InvocationID docker-hass)
```

where docker-hass is your service. I should probably add an alias for this to my dotfiles.
