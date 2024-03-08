{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self, 
    nix-darwin, 
    nixpkgs, 
    ... 
  } @ inputs: let
    inherit (self) outputs;

    # nixos
    nixOSConfig = { pkgs, ... }: {
      system = "x86_64-linux";
    };
  
    # nix-darwin
    darwinConfig = { pkgs, ... }: {
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
    };
  in
  {
    darwinConfigurations = {
      work-mbp = nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [ 
          darwinConfig
          ./hosts/work/configuration.nix
        ];
      };
    };

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
         specialArgs = {inherit inputs outputs;};
         modules = [
          nixOSConfig 
          ./hosts/nixos/configuration.nix
        ];
      };
    };


    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."simple".pkgs;
  };
}
