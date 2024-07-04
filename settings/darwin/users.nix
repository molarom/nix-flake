{
  config,
  lib,
  ...
}: let
  cfg = config.darwinSettings;
in {
  options = {
    darwinSettings.enable = lib.mkEnableOption "enable darwin settings";

    darwinSettings.username = lib.mkOption "the username for the primary user of this system";
  };

  # Home-manager is excluded to make tracing down imports clearer.

  config = lib.mkIf cfg.enable {
    users.users."${cfg.username}" = {
      name = "${cfg.username}";
      home = "/Users/${cfg.username}";
    };

    nix-homebrew = {
      enable = true;
      user = "${cfg.username}";
      autoMigrate = true;
    };
  };
}
