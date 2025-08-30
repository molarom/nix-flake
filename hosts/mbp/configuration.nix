{pkgs, ...}: {
  # Nixpkgs
  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.variables = {
    "HOMEBREW_NO_ANALYTICS" = "1";
  };

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
      "docker"
    ];
    casks = [
      "orbstack"
      "discord"
      "spotify"
    ];
  };

  programs = {
    # Create /etc/zshrc that loads the nix-darwin environment.
    zsh = {
      enable = true;
    };
    tmux.enable = true;
  };

  ids.gids.nixbld = 350;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
