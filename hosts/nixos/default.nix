{pkgs, ...}: let
  bepperson = {
    isNormalUser = true;
    description = "Brandon";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };
in {
  imports = [
    ./configuration.nix

    ../../settings/nixos
  ];

  nixosSettings = {
    enable = true;
    user = bepperson;
  };

  home-manager.users = {
    "${bepperson.name}" = import ../../home/linux;
  };
}
