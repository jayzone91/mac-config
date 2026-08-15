{ inputs, ... }:

{
  imports = [
  inputs.home-manager.darwinModules.home-manager
  ];

nix.enable = false;

  system.stateVersion = 6;
  system.primaryUser = "jay";

  users.users.jay = {
    home = "/Users/jay";
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
