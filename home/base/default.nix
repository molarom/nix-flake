{
  imports = [
    ./cli.nix
    ./pass.nix
    ./tmux.nix
    ./zsh.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
