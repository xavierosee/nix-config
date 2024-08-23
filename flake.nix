{
  description = "System flake configuration file for macOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";

    flake-utils.url = "github:numtide/flake-utils";

    nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
        url="github:nix-community/home-manager/release-24.05";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
        url = "github:zhaofengli/nix-homebrew";
        inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    nixpkgs-darwin,
    flake-utils,
    nix-darwin,
    home-manager,
    nix-homebrew
  }: 
    let
        config.allowUnfree = true;
        forSystems = function:
            nixpkgs.lib.genAttrs [ "x86_64-darwin"] (system:
                function {
                    inherit system;
                }
            );
    in {
        # NixOs configurations
        /* Placeholder for future configs */

        # macOS configurations
        darwinConfigurations = {
            macbook-pro = nix-darwin.lib.darwinSystem {
                system = "x86_64-darwin";
                modules = [
                    ./hosts/macbook-pro
                    ./users/xavier
                    home-manager.darwinModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.xavier = import ./users/xavier/home-manager.nix;
                    }
                    nix-homebrew.darwinModules.nix-homebrew
                ];
            };
        };

    };
}
