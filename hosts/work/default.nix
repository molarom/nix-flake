let
  brandon = {
    name = "brandon";
    home = "/Users/brandon";
  };
in {
  imports = [
    ./configuration.nix

    ../../settings/darwin
  ];

  darwinSettings = {
    enable = true;
    user = brandon;
  };

  home-manager.users = {
    "${brandon.name}" = import ../../home/work;
  };
}
