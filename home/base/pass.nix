{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    pass
    ripasso-cursive
  ];
}
