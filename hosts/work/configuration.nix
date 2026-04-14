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
      "bruno-cli"
      "cairo"
      "chainctl"
      "detect-secrets"
      "gitleaks"
      "golangci-lint"
      "graphviz"
      "kind"
      "opa"
      "opencode"
      "opensc"
      "openssl"
      "qemu"
      "pinentry-mac"
      "pkg-config"
      "postgresql@16"
      "pre-commit"
      "swtpm"
      "trivy"
      "wget"
      "yamllint"
      "ykman"
      "yubikey-personalization"
    ];
    casks = [
      "bruno"
      "coderabbit"
      "cursor"
      "cursor-cli"
      "docker-desktop"
      "figma"
      "slack"
      "notion"
      "zoom"
    ];
    taps = [
      "chainguard-dev/tap"
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
