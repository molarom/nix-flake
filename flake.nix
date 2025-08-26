{
  description = "Nix Config Flake";

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
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = {
    self,
    nix-darwin,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;

    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    # Overlay ./lib to extend nixpkgs.lib
    overlay = final: prev: {
      lib = prev.lib.extend (_final: super: {
        romalor = import ./lib {lib = super;};
      });
    };

    # Home Manager modules
    hm = import ./modules/home-manager;
    hmList =
      builtins.attrValues (builtins.removeAttrs hm ["default"]);
  in {
    #####################################################
    # Modules
    #####################################################

    homeManagerModules =
      hm
      // {
        default = {...}: {imports = hmList;};
      };

    #####################################################
    # Overlays
    #####################################################
    overlays.default = overlay;

    #####################################################
    # Darwin Machines
    #####################################################

    darwinConfigurations = {
      # Work MBP
      work-mbp = nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./overlays/nixpkgs.nix
          ./hosts/work
          inputs.home-manager.darwinModules.home-manager
          inputs.nix-homebrew.darwinModules.nix-homebrew
        ];
      };

      # Personal MBA
      mba = nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./overlays/nixpkgs.nix
          ./hosts/mba
          inputs.home-manager.darwinModules.home-manager
          inputs.nix-homebrew.darwinModules.nix-homebrew
        ];
      };

      # Personal MBP
      mbp = nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./overlays/nixpkgs.nix
          ./hosts/mbp
          inputs.home-manager.darwinModules.home-manager
          inputs.nix-homebrew.darwinModules.nix-homebrew
        ];
      };
    };

    #####################################################
    # NixOS Machines
    #####################################################

    nixosConfigurations = {
      # NixOS desktop
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./overlays/nixpkgs.nix
          ./hosts/nixos
          inputs.home-manager.nixosModules.home-manager
        ];
      };

      # Testing k3s on NixOS VMs.
      testVM = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./overlays/nixpkgs.nix
          ./hosts/k8s
          inputs.home-manager.nixosModules.home-manager
          {
            virtualisation.vmVariant.virtualisation.host.pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          }
        ];
      };
    };
    #####################################################
    # VMs
    #####################################################
    packages.aarch64-darwin.testVM = self.nixosConfigurations.testVM.config.system.build.vm;

    # Expose the package set, including overlays, for convenience.
    legacyPackages = nixpkgs.lib.genAttrs systems (
      system:
        import nixpkgs {
          inherit system;
          overlays = [overlay];
        }
    );
  };
}
