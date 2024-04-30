{
  imports = [
    ./apps.nix
    ./git.nix
    ./pass.nix
    ./tmux.nix
    ./utils.nix
    ./zsh.nix
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs.home-manager.enable = true;
}
