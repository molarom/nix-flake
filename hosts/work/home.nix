{ config, pkgs, inputs, ... }:

{
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
    username = "bepperson";
    homeDirectory = "/Users/bepperson";
    file.".zshrc".text = ''
      autoload -U compinit && compinit
    '';
    stateVersion = "23.11"; 
    packages = with pkgs; [
      actionlint
      awscli2
      flameshot
      gh
      git
      gnupg
      go
      go-migrate
      jq
      kubectl
      kubernetes-helm
      nodePackages.pnpm
      nodejs_20
      pandoc
      pgformatter
      postgresql_15
      python310
      ripgrep
      sops
      synth
      terraform
      trivy
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
      UseKeychain = "yes";
    };
  };

  programs.home-manager.enable = true;
}
