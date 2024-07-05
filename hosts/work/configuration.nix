{pkgs, ...}: {
  users.users.brandon = {
    name = "brandon";
    home = "/Users/brandon";
  };

  # Nixpkgs
  nixpkgs.hostPlatform = "aarch64-darwin";

  # System Packages
  environment.systemPackages = with pkgs; [
    kind
  ];

  # Homebrew programs
  homebrew = {
    casks = [
      "docker"
      "discord"
      "iterm2"
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
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
