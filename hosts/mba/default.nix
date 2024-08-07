let
  molarom = {
    name = "molarom";
    home = "/Users/molarom";
  };
in {
  imports = [
    ./configuration.nix

    ../../settings/darwin
  ];

  darwinSettings = {
    enable = true;
    user = molarom;
  };

  home-manager.users = {
    "${molarom.name}" = import ../../home/darwin;
  };
}
