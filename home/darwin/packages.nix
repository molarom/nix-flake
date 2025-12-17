{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      claude-code
      corepack
      cmake
      gcc
      gnumake
      go
      graphviz
      nodejs_22
      go-tools
      govulncheck
      krew
      kubectl
      parallel
      qpdf
      tree
      trivy
      unixtools.watch
      (pkgs.python313.withPackages (p: [
        p.pylatexenc # render-markdown.nvim
      ]))
      (pkgs.texliveBasic.withPackages (p: [
        p.xcolor
        p.acrotex
      ]))
    ];
  };
}
