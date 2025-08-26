{outputs, ...}: {
  nixpkgs.overlays = [
    outputs.overlays.default
  ];
}
