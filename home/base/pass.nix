{pkgs, ...}: {
  home.packages = with pkgs; [
    pass
    passExtensions.pass-import
    ripasso-cursive
  ];
}
