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
      "anomalyco/tap/opencode"
      "bruno-cli"
      "cairo"
      "crane"
      "detect-secrets"
      "gitleaks"
      "golangci-lint"
      "graphviz"
      "kind"
      "opa"
      "opencode"
      "opensc"
      "openssl"
      "pgcli"
      "pgformatter"
      "pinentry-mac"
      "pkg-config"
      "postgresql@16"
      "pre-commit"
      "qemu"
      "stripe"
      "sqlfluff"
      "swtpm"
      "tilt"
      "trivy"
      "uv"
      "wget"
      "yamllint"
      "ykman"
      "yubikey-personalization"
    ];
    casks = [
      "bruno"
      "coderabbit"
      "cursor"
      "docker-desktop"
      "figma"
      "notion"
      "slack"
      "zoom"
    ];
    taps = [
      "anomalyco/tap"
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
