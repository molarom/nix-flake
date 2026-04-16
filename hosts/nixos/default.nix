{
  outputs,
  pkgs,
  ...
}: let
  bepperson = {
    name = "bepperson";
    isNormalUser = true;
    description = "Brandon";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
    openssh = {
      authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMfNFHMiH/LegdUOw3+udbO2fr/fT1iEWAYqQUOe7k3m"
      ];
    };
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

  home-manager.users."${bepperson.name}" = {
    imports = [
      outputs.homeManagerModules.default
      ../../home/linux
    ];
  };
}
