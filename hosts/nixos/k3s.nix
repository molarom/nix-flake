{
  config,
  pkgs,
  ...
}: {
  boot.supportedFilesystems = [
    "ext4"
    "btrfs"
    "xfs"
    #"zfs"
    "ntfs"
    "fat"
    "vfat"
    "exfat"
    "nfs" # required by longhorn
  ];
  boot.kernelModules = ["kvm-amd" "vfio-pci"];
  boot.extraModprobeConfig = "options kvm_amd nested=1"; # for amd cpu

  environment.systemPackages = with pkgs; [
    fluxcd
    k3s
    kubevirt
    ipvsadm
    libvirt
    nfs-utils
    multus-cni
  ];

  services = {
    # qemu settings
    qemuGuest = {
      enable = true;
    };
    rpcbind.enable = true;
    k3s = {
      enable = true;
      clusterInit = true;
      role = "server";
      extraFlags = toString [
        "--kube-proxy-arg proxy-mode=ipvs"
        "--flannel-backend=none"
        "--disable-network-policy"
        "--disable=traefik"
        "--write-kubeconfig-mode=644"
      ];
    };
  };
  services.openiscsi = {
    enable = true;
    name = "${config.networking.hostName}-initiatorhost";
  };
  boot.kernel.sysctl = {
    # --- filesystem --- #
    # increase the limits to avoid running out of inotify watches
    "fs.inotify.max_user_watches" = 524288;
    "fs.inotify.max_user_instances" = 1024;

    # --- network --- #
    "net.bridge.bridge-nf-call-iptables" = 1;
    "net.core.somaxconn" = 32768;
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv4.neigh.default.gc_thresh1" = 4096;
    "net.ipv4.neigh.default.gc_thresh2" = 6144;
    "net.ipv4.neigh.default.gc_thresh3" = 8192;
    "net.ipv4.neigh.default.gc_interval" = 60;
    "net.ipv4.neigh.default.gc_stale_time" = 120;

    "net.ipv6.conf.all.disable_ipv6" = 1; # disable ipv6

    # --- memory --- #
    "vm.swappiness" = 0; # don't swap unless absolutely necessary
  };

  virtualisation.vswitch = {
    enable = true;
    # reset the Open vSwitch configuration database to a default configuration on every start of the systemd ovsdb.service
    resetOnStart = false;
  };

  #networking.vswitches = {
  #  # https://github.com/k8snetworkplumbingwg/ovs-cni/blob/main/docs/demo.md
  #  ovsbr1 = {
  #    # Attach the interfaces to OVS bridge
  #    # This interface should not used by the host itself!
  #    interfaces.eno1 = {};
  #  };
  #};
  networking.firewall.allowedUDPPorts = [
    # 8472 # k3s, flannel: required if using multi-node for inter-node networking
  ];

  systemd.tmpfiles.rules = [
    "L+ /opt/cni/bin - - - - /var/lib/rancher/k3s/data/current/bin"
    "D /var/lib/rancher/k3s/agent/etc/cni/net.d 0751 root root - -"
    "L+ /etc/cni/net.d - - - - /var/lib/rancher/k3s/agent/etc/cni/net.d"
  ];
}
