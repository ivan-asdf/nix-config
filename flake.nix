{
  inputs = {
    # nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, nur, nix-index-database, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          # cudaSupport = true;
          # permittedInsecurePackages = [
          #   "dcraw"
          # ];
          # allowBroken = true;
        };
        overlays = [ nur.overlay ];
      };
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./system/configuration.nix
          nix-index-database.nixosModules.nix-index
          {
            programs.command-not-found.enable = false;
            programs.nix-index.enable = true;
          }
        ];
      };

      homeConfigurations = {
        ivan = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            #{ nixpkgs.overlays = [ nur.overlay ]; }
            ./home/home.nix
          ];
        };
      };
    };
}
