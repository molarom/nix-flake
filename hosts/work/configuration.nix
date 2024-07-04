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

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
