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
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = {
    self,
    nix-darwin,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # nix-darwin
    darwinConfig = {
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
    };
  in {
    darwinConfigurations = {
      # Work MBP
      work-mbp = nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          darwinConfig
          ./modules/base.nix
          ./hosts/work/configuration.nix
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs outputs;};
              users = {
                "brandon" = import ./home/work;
              };
            };
          }
          inputs.nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = "brandon";
              autoMigrate = true;
            };
          }
        ];
      };

      # Personal MBA
      mba = nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          darwinConfig
          ./modules/base.nix
          ./hosts/mba/configuration.nix
          ./hosts/mba/home.nix
          inputs.home-manager.darwinModules.home-manager
          inputs.nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = "molarom";
              autoMigrate = true;
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
          ./modules/base.nix
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
      amaterasu = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./modules/base.nix
          ./hosts/k8s/configuration.nix
        ];
      };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."simple".pkgs;
  };
}
