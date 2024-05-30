{pkgs, ...}: {
  users.groups.admin = {};
  users.users = {
    admin = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      password = "admin";
      group = "admin";
    };
  };

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 2048; # Use 2048MiB memory.
      cores = 3;
      graphics = false;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  # Networking
  networking = {
    hostName = "k8s-master-1"; # Define your hostname.
    #networkmanager.enable = true;

    ## Open ports in the firewall.
    #firewall.allowedTCPPorts = [
    #  22
    #  2379-2380
    #];
  };
  environment.systemPackages = with pkgs; [
    k3s
  ];

  system.stateVersion = "23.05";
}
