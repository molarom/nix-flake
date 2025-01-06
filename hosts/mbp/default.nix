let
  romalor = {
    name = "romalor";
    home = "/Users/romalor";
  };
in {
  imports = [
    ./configuration.nix

    ../../settings/darwin
  ];

  darwinSettings = {
    enable = true;
    user = romalor;
  };

  home-manager.users = {
    "${romalor.name}" = import ../../home/darwin;
  };
}
