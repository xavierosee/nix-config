{
  description = "Nix systems and tools by xavierosee";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    }
  };

  outputs = { self, nix-darwin, nixpkgs, home-manager, ... }@inputs: let
    mkSystem = import ./lib/mksystem.nix{
      inherit overlays nixpkgs inputs;
    };

  in
  {
    darwinConfigurations.macbook-pro = mkSystem "macbook-pro" {
      system = "x86_64-darwin";
      user = "xavierosee";
      darwin = true;
    };
  };
}
