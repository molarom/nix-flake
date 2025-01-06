{
  modulesPath,
  ...
}: {
  imports = [
    ./configuration.nix

    ../../settings/nixos
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];
}
