{...}: let
  username = "molarom";
in {
  home-manager.users = {
    "${username}" = import ../../home/darwin;
  };
  nix-homebrew = {
    enable = true;
    user = "${username}";
    autoMigrate = true;
  };
}
