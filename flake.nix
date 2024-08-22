{
  description = "System flake configuration file for macOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
        url="github:nix-community/home-manager/release-24.05";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
        url = "github:zhaofengli-wip/nix-homebrew";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    homebrew-core = {
        url = "github:homebrew/homebrew-core";
        flake = false;
    };

    homebrew-cask = {
        url = "github:homebrew/homebrew-cask";
        flake = false;
    };

    homebrew-bundle = {
        url = "github:homebrew/homebrew-bundle";
        flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-darwin, unstable, home-manager, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#macbook-pro
    darwinConfigurations."macbook-pro" =
        nix-darwin.lib.darwinSystem {
            system = "x86_64-darwin";
            modules = [
                ./configuration.nix

                home-manager.darwinModules.home-manager
                {
                    # `home-manager` config
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.xavier = import ./home.nix;
                }

                nix-homebrew.darwinModules.nix-homebrew
                {
                    nix-homebrew = {
                        enable = true;
                        user = "xavier";

                        taps = {
                            "homebrew/homebrew-core" = homebrew-core;
                            "homebrew/homebrew-cask" = homebrew-cask;
                            "homebrew/homebrew-bundle" = homebrew-bundle;
                        };
                        mutableTaps = false;
                    };
                }
            ];
        };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macbook-pro".pkgs;
  };
}
