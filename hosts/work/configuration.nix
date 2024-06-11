{pkgs, ...}: {
  users.users.brandon = {
    name = "brandon";
    home = "/Users/brandon";
  };

  # Nixpkgs
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override {fonts = ["Mononoki"];})
  ];

  # System Packages
  environment.systemPackages = with pkgs; [
    kind
  ];

  # Homebrew programs
  homebrew = {
    enable = true;
    global = {
      autoUpdate = true;
    };
    onActivation.cleanup = "zap";

    casks = [
      "docker"
      "iterm2"
    ];
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
