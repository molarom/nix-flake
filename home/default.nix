{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./base
  ];
  programs.ssh = {
    enable = true;
    extraOptionOverrides = {
      AddKeysToAgent = "yes";
      IdentitiesOnly = "yes";
    };
  };
  programs.home-manager.enable = true;
}
