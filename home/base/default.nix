{
  imports = [
    ./cli.nix
    ./pass.nix
    ./tmux.nix
    ./zsh.nix
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    file.".zshrc".text = ''
      autoload -U compinit && compinit
    '';
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
