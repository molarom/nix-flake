{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      corepack
      cmake
      gcc
      gnumake
      go
      graphviz
      texliveBasic
      nodejs_22
      go-tools
      govulncheck
      krew
      kubectl
      parallel
      tree
      trivy
      unixtools.watch
      (pkgs.python313.withPackages (p: [
        p.pylatexenc # render-markdown.nvim
      ]))
    ];
  };
}
