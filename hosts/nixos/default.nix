{pkgs, ...}: let
  bepperson = {
    name = "bepperson";
    isNormalUser = true;
    description = "Brandon";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };
in {
  imports = [
    ./configuration.nix
    ./services.nix

    ../../settings/nixos
  ];

  nixSettings = {
    enable = true;
    user = bepperson;
  };

  home-manager.users = {
    "${bepperson.name}" = import ../../home/linux;
  };
}
