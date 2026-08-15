{
  description = "MacOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, ... }:
  {
    darwinConfigurations.MacbookPro = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./hosts/MacbookPro
      ];

    };
  };
}
