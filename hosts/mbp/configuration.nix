{pkgs, ...}: {
  # Nixpkgs
  nixpkgs.hostPlatform = "aarch64-darwin";

  # System Packages
  environment.systemPackages = with pkgs; [
  ];

  # nix = {
  #   linux-builder = {
  #     enable = true;
  #     ephemeral = true;
  #     maxJobs = 4;
  #     config = {
  #       virtualisation = {
  #         darwin-builder = {
  #           diskSize = 40 * 1024;
  #           memorySize = 8 * 1024;
  #         };
  #         cores = 6;
  #       };
  #     };
  #   };
  #   settings.trusted-users = ["@admin"];
  # };

  homebrew = {
    brews = [
      "kind"
      "openssl"
      "golangci-lint"
    ];
    casks = [
      "docker"
      "discord"
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
