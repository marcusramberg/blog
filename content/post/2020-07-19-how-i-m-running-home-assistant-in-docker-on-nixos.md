---
author:
- Marcus Ramberg
date: "2020-07-19T20:54:00+02:00"
draft: false
publishDate: "2020-07-19T00:00:00+02:00"
tags:
- homeautomation
- nix
title: How I'm running Home Assistant in docker on NixOS
---

For the last few years I've been into home automation, and since I buy random stuff from different vendors and with
various protocols, I use [Home Assistant](https://home-assistant.io/) to tie it all together. My main home server is a
NixOS box, but for a long while I was running home assistant on my old Arch mac mini, because it was such a chore to
handle dependencies with the NixOS home assistant service.

Typically home assistant just installs what you need on the fly, but with the nixos version you need to declare
everything manually. However, this winter I migrated over to running NixOS in a docker container declaratively. Recent
nixos has gained support for running these containers in systemd.

Setting this up is really easy

```nix
    docker-containers.hass = {
      image = "homeassistant/home-assistant:0.112.4";
      environment = { TZ = "Europe/Oslo"; };
      extraDockerOptions = ["--net=host" "--device=/dev/serial/by-id/usb-0658_0200-if00"];
      volumes = [ "/var/lib/homeassistant:/config" ];
    };
```

Here I'm using the official image, and also demonstrating how to set extra docker options, like host networking or
forwarding a usb device.

Nixos also provides other commonly used services natively as nix services.

```nix
    services.influxdb.enable = true;
    services.mosquitto = {
      enable = true;
      host = "0.0.0.0";
      users = { hass = {acl = [ "topic readwrite #" ]; password = "notmypassword"; }; };
      extraConf = "log_type debug";
    };
```

Now you can also easily upgrade your install by changing the docker image version and doing `nixos-rebuild switch`
