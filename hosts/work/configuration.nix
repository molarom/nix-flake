{pkgs, ...}: {
  users.users.brandon = {
    name = "brandon";
    home = "/Users/brandon";
  };

  # Nixpkgs
  nixpkgs.hostPlatform = "aarch64-darwin";

  # System Packages
  environment.systemPackages = with pkgs; [
  ];

  # Homebrew programs
  homebrew = {
    brews = [
      "kind"
      "openssl"
      "pre-commit"
      "yamllint"
      "detect-secrets"
    ];
    casks = [
      "docker"
      "slack"
      "spotify"
    ];
  };

  services = {
    nix-daemon = {
      enable = true;
    };
  };

  programs = {
    # Create /etc/zshrc that loads the nix-darwin environment.
    zsh = {
      enable = true;
    };
    tmux.enable = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
