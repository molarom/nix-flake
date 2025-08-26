{lib}: let
  romalor = lib.fix (self: {
    strings = import ./strings.nix {inherit lib;};
    lists = import ./lists.nix {inherit lib self;};
  });
in
  romalor
