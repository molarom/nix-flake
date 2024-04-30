{
  config,
  pkgs,
  inputs,
  ...
}: {
  home = {
    stateVersion = "23.11";
    packages = with pkgs; [
      cmake
      firefox
      gcc
      gnumake
      go
    ];
  };

  programs.ssh = {
    enable = true;
    extraOptionOverrides = {
      AddKeysToAgent = "yes";
      IdentitiesOnly = "yes";
    };
  };
}
