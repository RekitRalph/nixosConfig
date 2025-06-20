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

    # nixos-cosmic = {
    #   url = "github:lilyinstarlight/nixos-cosmic";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixpkgs.follows = "nixos-cosmic/nixpkgs"; # NOTE: change "nixpkgs" to "nixpkgs-stable" to use stable NixOS release

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    # stylix ={
    #   url = "github:danth/stylix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs@{ 
    self, 
    nixpkgs, 
    nixpkgs-stable,
    home-manager,
    nixos-cosmic,
    ...
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
          
          nixos-cosmic.nixosModules.default
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
        
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.evan = import ./modules/home/home.nix;

            home-manager.extraSpecialArgs = {
              
            };

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

              home-manager.extraSpecialArgs = {
              
              };

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
    };
  };
}
