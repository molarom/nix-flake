{pkgs, ...}: {
  imports = [
    ../../modules/home/expvarmon
  ];

  # Add homebrew packages to path.
  programs.zsh = {
    initExtra = ''
      export PATH=$PATH:/opt/homebrew/bin
    '';
  };

  home.packages = with pkgs; [
    act
    ansible
    awscli2
    fluxcd
    gh
    git
    gnupg
    go
    go-migrate
    go-swag
    go-tools
    gofumpt
    golangci-lint
    govulncheck
    istioctl
    jq
    krew
    kubectl
    kubernetes-helm
    kustomize
    nodePackages.pnpm
    nodejs_20
    open-policy-agent
    packer
    pandoc
    parallel
    pass
    pgcli
    postgresql_15
    python312
    regal
    ripgrep
    sops
    sshuttle
    terraform
    terragrunt
    tree
    trivy
    turbo
    typescript
    unixtools.watch
    yq
  ];
}
