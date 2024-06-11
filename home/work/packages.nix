{pkgs, ...}: let
  expvarmon = pkgs.buildGoModule {
    pname = "expvarmon";
    version = "latest";

    src = pkgs.fetchFromGitHub {
      owner = "divan";
      repo = "expvarmon";
      rev = "8e0b3d2";
      hash = "sha-256-+dOnks3dUOLrUmV31bwmRAC3SHm1hHO/wabB9IEa0M=";
    };

    vendorHash = null;
  };
in {
  home = {
    packages = with pkgs; [
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
      pgformatter
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
  };
}
