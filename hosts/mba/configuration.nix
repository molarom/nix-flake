{pkgs, ...}: {
  users.users.molarom = {
    name = "molarom";
    home = "/Users/molarom";
  };

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["Mononoki"];})
  ];

  # System Packages
  environment.systemPackages = with pkgs; [
    dnsmasq
    qemu
  ];

  homebrew = {
    enable = true;
    global = {
      autoUpdate = true;
    };
    onActivation.cleanup = "zap";

    casks = [
      "docker"
      "discord"
      "spotify"
    ];
  };

  services = {
    dnsmasq = {
      enable = true;
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
