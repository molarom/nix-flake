{
  modulesPath,
  pkgs,
  ...
}: let
  testuser = {
    name = "testuser";
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };
in {
  imports = [
    ./configuration.nix

    ../../settings/nixos
    (modulesPath + "/virtualisation/qemu-vm.nix")
  ];

  nixSettings = {
    enable = true;
    user = testuser;
  };
}
