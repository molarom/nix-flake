{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      claude-code
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
        p.acrotex
        p.conv-xkv
        p.everyshi
        p.metafont
        p.xcolor
        p.xkeyval
      ]))
    ];
  };
}
