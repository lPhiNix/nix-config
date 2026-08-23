{
  description = "PhiNix Nix Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    mkHost = {
      path,
      system ? "x86_64-linux",
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          path

          ./modules/core.nix
          ./modules/desktop.nix
          ./modules/audio.nix
          ./modules/services.nix

          home-manager.nixosModules.home-manager
          ./home
        ];
      };
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    packages.${system} = import ./pkgs nixpkgs.legacyPackages.${system};

    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      noir = mkHost {path = ./hosts/noir/configuration.nix;};
    };
  };
}
