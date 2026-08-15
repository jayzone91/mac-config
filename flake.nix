{
  description = "MacOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, ... }:
  {
    darwinConfigurations.MacbookPro = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      modules = [
      ./hosts/MacbookPro
      ];
    };
  };
}
