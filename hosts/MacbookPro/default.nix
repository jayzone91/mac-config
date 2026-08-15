{ inputs, pkgs, ... }:

{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ../../modules/darwin/defaults
    ../../modules/darwin/security.nix
    ../../modules/darwin/updates.nix
    ../../modules/darwin/power.nix
  ];

  nix.enable = false;

  system.stateVersion = 6;
  system.primaryUser = "jay";

  programs.fish.enable = true;

  users.users.jay = {
    home = "/Users/jay";
    shell = pkgs.fish;
  };

  networking.hostName = "MacbookPro";
  networking.localHostName = "MacbookPro";


  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit inputs;
    };

    users.jay = import ../../home/jay.nix;
  };
}
