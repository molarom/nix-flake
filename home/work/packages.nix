{pkgs, ...}: {
  home.packages = with pkgs; [
    awscli2
    corepack
    fluxcd
    git
    glab
    go
    go-tools
    govulncheck
    istioctl
    krew
    kubectl
    kubernetes-helm
    kustomize
    nodejs_22
    pandoc
    parallel
    (pkgs.python313.withPackages (p: [
      p.pylatexenc # render-markdown.nvim
      p.pipx
    ]))
    regal
    sops
    terraform
    terragrunt
    tree
    trivy
    unixtools.watch
  ];
}
