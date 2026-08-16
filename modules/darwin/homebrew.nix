{ inputs, ... }:

{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    enable = true;

    user = "jay";

    enableRosetta = true;

    autoMigrate = true;

    mutableTaps = true;
  };

  homebrew = {
    enable = true;

    casks = [
      "adguard"
      "alfred"
      "appcleaner"
      "dockdoor"
      "ghostty"
      "google-chrome@dev"
      "openvpn-connect"
      "setapp"
      "visual-studio-code"
      "github"
    ];

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
  };
}
