# /etc/nixos/flake.nix
{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    maccel.url = "github:Gnarus-G/maccel";

  };

  outputs =
    inputs@{ self
    , nixpkgs
    , nixpkgs-stable
    , home-manager
    , ...
    }: {

      nixosConfigurations = {

        starchy = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";

          specialArgs = {
            inherit inputs;
            pkgs-stable = import nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
          };

          modules = [
            ./hosts/starchy/configuration.nix
            # inputs.stylix.nixosModules.stylix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.evan = import ./modules/home/home.nix;
              home-manager.backupFileExtension = "backup";

              home-manager.extraSpecialArgs = { };

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };

        lappy = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";

          specialArgs = {
            pkgs-stable = import nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
          };

          modules = [
            ./hosts/lappy/configuration.nix
            # inputs.stylix.nixosModules.stylix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.evan = import ./modules/home/home.nix;
              home-manager.backupFileExtension = "backup";

              home-manager.extraSpecialArgs = { };

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
      };
    };
}
