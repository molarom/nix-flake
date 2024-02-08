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
      awscli2
      flameshot
      gh
      git
      gnupg
      go
      jq
      kubectl
      kubernetes-helm
      nodePackages.pnpm
      nodejs_20
      pandoc
      postgresql_15
      python310
      ripgrep
      sops
      terraform
      trivy
      unixtools.watch
      yarn
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
