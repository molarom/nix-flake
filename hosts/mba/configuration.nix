{pkgs, ...}: {
  # Nixpkgs
  nixpkgs.hostPlatform = "aarch64-darwin";

  # System Packages
  environment.systemPackages = with pkgs; [
    dnsmasq
    qemu
  ];

  homebrew = {
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
