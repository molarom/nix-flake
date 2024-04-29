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
    username = "bepperson";
    homeDirectory = "/home/bepperson";
    file.".zshrc".text = ''
      autoload -U compinit && compinit
    '';
    stateVersion = "23.11";
    packages = with pkgs; [
      cmake
      firefox
      flameshot
      gcc
      git
      gnupg
      gnumake
      go
      jq
      pass
      ripgrep
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
