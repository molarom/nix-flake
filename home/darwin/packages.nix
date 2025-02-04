{pkgs, ...}: {
  imports = [
    ../../modules/home/expvarmon
  ];

  home = {
    packages = with pkgs; [
      cmake
      gcc
      gnumake
      go
      graphviz
      python312
      texliveBasic
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
