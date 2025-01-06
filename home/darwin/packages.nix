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
      python312
      texliveBasic
      rustup
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
