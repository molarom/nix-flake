{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      cmake
      firefox
      gcc
      gnumake
      go
      spotify
      texliveBasic
      protonmail-desktop
      pgcli
    ];
  };
}
