{outputs, ...}: let
  nixos = {
    name = "nixos";
    home = "/home/nixos";
  };
in {
  imports = [
    ./configuration.nix

    ../../settings/nixos
  ];

  nixSettings = {
    enable = true;
    user = nixos;
  };

  home-manager.users."${nixos.name}" = {
    imports = [
      outputs.homeManagerModules.default
      ../../home/work
    ];
  };
}
