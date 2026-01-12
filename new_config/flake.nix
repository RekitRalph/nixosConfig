{
  description = "Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    maccel.url = "github:Gnarus-G/maccel";

    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      mkSystem = hostname: nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
          pkgs-stable = import inputs.nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
        };

        modules = [
          # Custom options definition
          ./options

          # Core system modules (always loaded)
          ./modules/system/core

          # Shared settings
          ./modules/system/shared

          # Desktop environment (conditional)
          ./modules/system/desktop

          # Hardware-specific (conditional)
          ./modules/system/hardware

          # Optional features (conditional)
          ./modules/system/optional

          # System programs
          ./modules/system/programs

          # Overlays
          ./overlays

          # Host-specific configuration (includes myOptions settings)
          ./hosts/${hostname}/configuration.nix

          # Home-Manager
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";

              extraSpecialArgs = {
                inherit inputs hostname;
                hostConfig = config;
              };

              users.${config.myOptions.user.username} = import ./modules/home;
            };
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        starchy = mkSystem "starchy";
        lappy = mkSystem "lappy";
      };
    };
}
