{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      cmake
      gcc
      gnumake
      go
    ];
  };
}
