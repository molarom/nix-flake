{pkgs, ...}: {
  imports = [
    ../../modules/home/expvarmon
  ];

  home.packages = with pkgs; [
    ansible
    awscli2
    expvarmon
    flameshot
    fluxcd
    gh
    git
    gnupg
    go
    go-migrate
    go-swag
    gofumpt
    golangci-lint
    jq
    kubectl
    kubernetes-helm
    krew
    kustomize
    istioctl
    nodePackages.pnpm
    nodejs_20
    packer
    pandoc
    parallel
    pass
    postgresql_15
    python310
    ripgrep
    sshuttle
    sops
    sqlc
    terraform
    terragrunt
    tree
    trivy
    turbo
    typescript
    unixtools.watch
    yarn
    yq
  ];
}
