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
    homeDirectory = "/home/bepperson";
    file.".zshrc".text = ''
      autoload -U compinit && compinit
    '';
    stateVersion = "23.11"; 
    packages = with pkgs; [
      flameshot
      git
      gnupg
      go
      jq
      ripgrep
      sops
      synth
      terraform
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
