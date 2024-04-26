{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./neovim.nix
    ./tmux.nix
    ./zsh.nix
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "brandon";
    homeDirectory = "/Users/brandon";
    file.".zshrc".text = ''
      autoload -U compinit && compinit
    '';
    stateVersion = "23.11";
    packages = with pkgs; [
      actionlint
      ansible
      awscli2
      flameshot
      fluxcd
      gh
      git
      gnupg
      go
      go-migrate
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
      trivy
      turbo
      typescript
      unixtools.watch
      yarn
      yq
    ];
  };

  programs.ssh = {
    enable = true;
    extraOptionOverrides = {
      AddKeysToAgent = "yes";
      IdentitiesOnly = "yes";
    };
  };

  programs.home-manager.enable = true;
}
