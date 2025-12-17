{outputs, ...}: {
  nixpkgs = {
    overlays = [
      (import ./texlive.nix)
      outputs.overlays.default
    ];
    # Allow unfree packages
    config = {
      allowUnfree = true;
    };
  };
}
