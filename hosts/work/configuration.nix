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
      "cairo"
      "detect-secrets"
      "kind"
      "opa"
      "openssl"
      "pinentry-mac"
      "pkg-config"
      "postgresql@16"
      "pre-commit"
      "wget"
      "yamllint"
      "ykman"
      "yubikey-personalization"
    ];
    casks = [
      "cursor"
      "cursor-cli"
      "docker-desktop"
      "figma"
      "slack"
    ];
  };

  ids.gids.nixbld = 350;

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
