{pkgs, ...}: let
  gc_settings =
    if pkgs.system == "aarch64-darwin"
    then {
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
    }
    else {dates = "weekly";};
in {
  nix = {
    package = pkgs.nix;
    settings = {
      # Enable Flakes
      experimental-features = ["nix-command" "flakes"];
      # Optimise nix store for every build.
      auto-optimise-store = true;
    };

    # Setup automatic garbage collection.
    gc =
      {
        automatic = true;
        options = "--delete-older-than 7d";
      }
      // gc_settings;
  };

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
