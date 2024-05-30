{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
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
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    homebrew-bundle,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # nix-darwin
    darwinConfig = {...}: {
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
      # Nixpkgs
      nixpkgs.hostPlatform = "aarch64-darwin";
      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
    };

    nixConfig = {...}: {
      # Nix options
      nix = {
        settings = {
          # Enable Flakes
          experimental-features = ["nix-command" "flakes"];
          # Optimise nix store for every build.
          auto-optimise-store = true;
        };

        # Setup automatic garbage collection.
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
      };
      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;
    };
  in {
    darwinConfigurations = {
      # Work MBP
      work-mbp = nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          darwinConfig
          nixConfig
          ./hosts/work/configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = "brandon";
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-bundle" = homebrew-bundle;
              };
              autoMigrate = true;
              mutableTaps = false;
            };
          }
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs outputs;};
              users = {
                "brandon" = import ./home/work;
              };
            };
          }
        ];
      };

      # Personal MBA
      mba = nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          darwinConfig
          ./hosts/mba/configuration.nix
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs outputs;};
              users = {
                "molarom" = import ./home/darwin;
              };
            };
          }
        ];
      };
    };

    # NixOS desktop
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          nixConfig
          ./hosts/nixos/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs outputs;};
              users = {
                "bepperson" = import ./home/linux;
              };
            };
          }
        ];
      };

      # Testing k3s on NixOS VMs.
      k8s = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          nixConfig
          ./hosts/k8s/configuration.nix
        ];
      };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."simple".pkgs;
  };
}
