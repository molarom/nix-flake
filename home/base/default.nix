{
  imports = [
    ./cli.nix
    ./neovim.nix
    ./pass.nix
    ./tmux.nix
    ./zsh.nix
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
