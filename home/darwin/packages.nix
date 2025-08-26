{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      cmake
      gcc
      gnumake
      go
      graphviz
      python313
      texliveBasic
      nodejs_22
      go-tools
      gofumpt
      govulncheck
      krew
      kubectl
      parallel
      pgcli
      tree
      trivy
      unixtools.watch
    ];
  };
}
