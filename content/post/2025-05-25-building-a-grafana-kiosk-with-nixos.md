+++
title = "Building a Grafana Kiosk With Nixos"
date = "2025-05-25"
tags = [
   "post"
]
categories = ["nixos"]

comments = true
draft = false
+++

At work, we're passionate about data diven decisions. Among others we use
[Grafana](https://grafana.com/) to visualize our key metrics .
We recently acquired a number of dual TV stands for our teams, and we wanted to use them to display our Grafana dashboards.
After experimenting with PI4s and finding the 4k support lacking, we decided to use go for a n100-based mini pc model.
Flashing and maintaining a number of pcs can be painful, so we desided to use a declarative setup and flash stateless
[NixOS](https://nixos.org) configurations. In order to bootstrap the PCs as quickly as possible, we use
[nixos-unattended-installer](https://github.com/chrillefkr/nixos-unattended-installer) and [disko](https://github.com/nix-community/disko).

From USB boot to installed on disk it's less than 10 minutes, and we can bake in all the configuration we need,
including team credentials and Grafana playlists to render. Using ssh we can also easily push new configurations if
needed.

## Disko

When you have a set of identical machines, [disko](https://github.com/nix-community/disko) is awesome for partitioning
and formatting disks. It's a declarative way of configuring your partition layout, and it integrates great with
nixos-unattended-installer.

First we need to add the disko module from the flake to our nixos system configuration
partitions.

```nix
        cs = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ...
```

then we set up actual partitions

```nix
                disko.devices.disk.nvme = {
                  device = "/dev/nvme0n1";
                  type = "disk";
                  content = {
                    type = "gpt";
                    partitions = {
                      ESP = {
                        type = "EF00";
                        size = "500M";
                        content = {
                          type = "filesystem";
                          format = "vfat";
                          mountpoint = "/boot";
                        };
                      };
                      root = {
                        size = "100%";
                        content = {
                          type = "filesystem";
                          format = "ext4";
                          mountpoint = "/";
                        };
                      };
                    };
                  };
                };
```

As you can see we're just setting up a small UEFI esp partition and allocating the rest of the space to root.

## nioxs-unattended-installer

This is a major win for us, as it's a completely hands off installation process. Unfortunately we have to disable secure
boot on the machines in the bios, if I had to do a lot more of them I'd probably automate the process using something
like a PI sending usb keyboard keystrokes with something like the [pikvm](https://pikvm.org/) recorder.

We just have to use their disko wrapper around the defined nixos configuration:

```nix
cs-installer = unattended-installer.lib.diskoInstallerWrapper self.nixosConfigurations.cs { };
```

## Graphics environment

In this example we chose xfce4 as a desktop environment, it's lightweight and supports multiple monitors in a way that's
pleasing to us. Having this also allows the team to debug any local issues like network problems, but if you want a more
locked down environment you could also use something like cage or i3 and not support any system access.
The nixos configuration looks something like this:

```nix
    services.xserver = {
      enable = true;
      desktopManager.xfce = {
        enable = true;
        enableScreensaver = false;
      };

      displayManager = {
        lightdm = {
          enable = true;
          greeters.tiny.enable = true;
        };
      };
    };

```

We have to setup the DM to ensure automatic login.

```nix
services.displayManager = {
  defaultSession = "xfce4";
  autoLogin.user = "kiosk";
};
```

## Grafana Kiosk

### Systemd services

The recommended way to run grafana kiosk is to use a systemd service. happily that is easy enough in nixos. This also
ensures that the kiosk app is automatically restarted if it should crash.

```nix
  systemd.services = {
    grafana-kiosk-1 = {
      enable = true;
      after = [ "network.target" ];
      wantedBy = [ "graphical.target" ];
      description = "Grafana Kiosk Screen 1";
      serviceConfig = {
        User = "kiosk";
        Restart = "always";
        RestartSec = "20";
      };
      environment = {
        DISPLAY = ":0";
        XAUTHORITY = "/home/kiosk/.Xauthority";
      };
      serviceConfig = {
        Type = "simple";
        ExecStartPre = [
          "${pkgs.xorg.xset}/bin/xset s off"
          "${pkgs.xorg.xset}/bin/xset s noblank"
          "${pkgs.xorg.xset}/bin/xset -dpms"
        ];
        ExecStart = "${pkgs.grafana-kiosk}/bin/grafana-kiosk com -URL ${builtins.elemAt settings.playlists 0}";
      };
    };
```

In order to run multiple of these, you'd start the second one with a offset param to grafana -kiosk like
-window-position 3841,0 for

Note that you'll probably need to authentication to your Grafana instance, see the
[README](https://github.com/grafana/grafana-kiosk) for details on various auth schemes. In our case we use IAP and
provide a service account with minimal permissions per team. You might also want to adjust RestartSec for your setup for
faster startup or to avoid restart back-off.

Other than that it's pretty much stock nixos config, like setting up networking and adding the kiosk user and enabling
openssh for remote management. I'll leave that as an exercise for the reader. The [nixos manual](https://nixos.org/manual/nixos/stable/#ch-configuration)
should come in handy.

Once you have this configuration in a flake, you can build a iso image for flashing using something like

```nix
nix build "path:.#nixosConfigurations.cs-installer.config.system.build.isoImage"
```

In this case we're using path: to be able to include credentials without adding them to the git index.

## Future improvements

- setting up a tunnel for management using something like [cloudflared](https://github.com/cloudflare/cloudflared) or
  [tailscale](https://tailscale.net/). nix already has nice modules for configuring both of these.
- Using something like [deploy-rs](https://github.com/serokell/deploy-rs) or
  (colmena](<https://github.com/zhaofengli/colmena>) to do OTA updates.
- Using external secrets management with something like [sops-nix](https://github.com/Mic92/sops-nix) to allow using a
  [cloud kvm](https://www.maxdaten.io/2023-12-11-deploy-sops-secrets-with-nix)
