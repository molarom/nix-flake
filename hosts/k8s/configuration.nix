{
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  users = {
    groups = {
      admin = {};
    };
    users = {
      admin = {
        isNormalUser = true;
        extraGroups = ["wheel"];
        group = "admin";
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtfZlG+Kvde5chORBhjFxo3H0yl1LKiC5QvyTWJyDT05RMV7d6WgUyMOdK3qbufKETLUq37Shs+nTyBQ9G5vCYT1aPe569R+gZf9u5365YvkOd1OJFFfQ3rtSpfIukqjtH4WF7x4d6/8/prepKt/lKefnRIJV9wZg4LpFyTyR9kR2hM/NodlZnQm05Gnckt2yj6XkCf5OF/u7kR7dbmJ6pzQzW+pGyYdPm0PHtJ/U2XN/NjYaLTYjI1gs59QsS0ab159LpuZlDhMFeBrJ2OJQy29IMWxwDu9tf+pwCtFFJlqGpu6TqBmpn9mH/P/9lkYcVGjN/HUFhv2q7c34CLvU8SRBR2fn9V+bfRT14z+o6ZXn+OohdMNlJtlbm5+RdnAxFq5XKWDjS5yVfQJaNPziyeQJBl5krqUdaumjCNvoVVEUy86HwF02y1iVm5Xyfk0OermfNjQmHLMwKVNyamEOWV6hY48gKVE/4mgnaXOTFJDrdA/JxcBQY7MsBapFCql/aaUDgmtjltNMzIbQxVdISZvH1xMlRQTetMnTk/ipVJWMAvOtoacJoeou0wh2nsqOrpadQDuSN9vR2ILK7h2g/eJwN/X/XeAx2aMOzGUSGnetSxs+CJPmZ0WVSyKu+9KqR7Zl2WBeKztSUmgXiDCjX6JVycrzLPHz++PsuLbJj1w== molarom@mba"
        ];
      };
    };
  };

  boot = {
    zfs.devNodes = "/dev/disk/by-partuuid";
    loader.grub = {
      enable = true;
      zfsSupport = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      mirroredBoots = [
        {
          devices = ["nodev"];
          path = "/boot";
        }
      ];
    };
  };

  services = {
    k3s = {
      enable = true;
      role = "server";
      token = "justadevtoken";
      extraFlags = lib.concatStringsSep " " [
        "--write-kubeconfig-mode=644"
        "--flannel-backend=none"
        "--disable-network-policy"
        "--disable-kube-proxy"
        "--disable=traefik"
        "--disable=servicelb"
        "--container-runtime-endpoint unix:///run/containerd/containerd.sock"
        "--snapshotter native"
      ];
    };
    openssh = {
      enable = true;
    };
    zfs = {
      autoScrub.enable = true;
    };
  };

  # Networking
  networking = {
    hostName = "amaterasu";
    hostId = "4e98920d";
    networkmanager.enable = true;

    # Open ports in the firewall.
    firewall = {
      allowedTCPPorts = [
        22
        2379
        2380
        5473
        6443
      ];
      allowedUDPPorts = [
        4789
        51820
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    calicoctl
    containerd
    k3s
    neovim
    wireguard-tools
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  virtualisation.containerd = {
    enable = true;
    settings = let
      fullCNIPlugins = pkgs.buildEnv {
        name = "full-cni";
        paths = with pkgs; [
          cni-plugins
          calico-cni-plugin
        ];
      };
    in {
      plugins."io.containerd.grpc.v1.cri".cni = {
        bin_dir = "${fullCNIPlugins}/bin";
        conf_dir = "/var/lib/rancher/k3s/agent/etc/cni/net.d/";
      };
      plugins."io.containerd.grpc.v1.cri".containerd = {
        snapshotter = "zfs";
      };
    };
  };

  # Time zone
  time.timeZone = "America/New_York";

  system.stateVersion = "23.11";
}
