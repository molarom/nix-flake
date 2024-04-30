{
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      cmake
      firefox
      gcc
      gnumake
      go
    ];
  };
}
