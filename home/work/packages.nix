{pkgs, ...}: {
  imports = [
    ../../modules/home/expvarmon
  ];

  # Add homebrew packages to path.
  programs.zsh = {
    initExtra = ''
      export PATH=$PATH:/opt/homebrew/bin:$HOME/go/bin
    '';
  };

  home.packages = with pkgs; [
    act
    ansible
    awscli2
    fluxcd
    gh
    git
    glab
    go
    go-migrate
    go-tools
    gofumpt
    golangci-lint
    govulncheck
    istioctl
    krew
    kubectl
    kubernetes-helm
    kustomize
    nodePackages.pnpm
    nodejs_20
    open-policy-agent
    pandoc
    parallel
    pgcli
    postgresql_15
    python312
    regal
    sops
    sshuttle
    terraform
    terragrunt
    tree
    trivy
    turbo
    typescript
    unixtools.watch
  ];
}
