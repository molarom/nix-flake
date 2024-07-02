{pkgs, ...}: {
  # General utility programs I use.
  home.packages = with pkgs; [
    flameshot
    git
    gnupg
    jq
    ripgrep
    yq
  ];
}
