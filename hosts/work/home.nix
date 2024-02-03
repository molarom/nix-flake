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
      jq
      nodejs_20
      nodePackages.pnpm
      pandoc
      postgresql_15
      python310
      ripgrep
      gnupg
      sops
      terraform
      trivy
      yarn
    ];
  };

  programs.home-manager.enable = true;
}
