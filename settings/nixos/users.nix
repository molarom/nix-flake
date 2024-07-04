{
  config,
  lib,
  ...
}: let
  cfg = config.nixSettings;
in {
  options = {
    nixSettings.enable = lib.mkEnableOption "enable nix settings";

    nixSettings.user = lib.mkOption {
      type = lib.types.attrs;
      description = ''
        the primary user of this system
        Ex:

        tommyT = {
          name = "tommyT";
          isNormalUser = true;
          description = "the T";
          extraGroups = ["wheel"];
          shell = pkgs.zsh;
        }
      '';
    };
  };

  # Home-manager is excluded to make tracing down imports clearer.

  config = lib.mkIf cfg.enable {
    users.users.${cfg.user.name} = cfg.user;
  };
}
