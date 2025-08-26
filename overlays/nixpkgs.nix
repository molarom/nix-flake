{outputs, ...}: {
  nixpkgs = {
    overlays = [
      outputs.overlays.default
    ];
    # Allow unfree packages
    config = {
      allowUnfree = true;
    };
  };
}
