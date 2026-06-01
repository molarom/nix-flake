{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      gcc
      git-lfs
      gnumake
      go
      go-tools
      govulncheck
      graphviz
      krew
      kubectl
      nodejs_22
      parallel
      qpdf
      tree
      trivy
      unixtools.watch
      uv
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
