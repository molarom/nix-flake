{lib}: let
  strings = import ./strings.nix {inherit lib;};
  lists = import ./lists.nix {inherit lib;};
in {
  strings = strings;
  lists = lists;
}
