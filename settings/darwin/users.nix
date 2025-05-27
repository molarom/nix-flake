{
  config,
  lib,
  ...
}: let
  cfg = config.darwinSettings;
in {
  options = {
    darwinSettings.enable = lib.mkEnableOption "enable darwin settings";

    darwinSettings.user = lib.mkOption {
      type = lib.types.attrs;
      description = ''
        the primary user of this system
        Ex:

        tommyT = {
          name = "tommyT";
          home = "/home/tommyT";
        }
      '';
    };
  };

  # Home-manager is excluded to make tracing down imports clearer.

  config = lib.mkIf cfg.enable {
    users.users.${cfg.user.name} = cfg.user;
    nix-homebrew = {
      enable = true;
      user = "${cfg.user.name}";
      autoMigrate = true;
    };

    # Required as part of nix-darwin's multi-user migration.
    system.primaryUser = "${cfg.user.name}";
  };
}
