{inputs, ...}:

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
    ];

    masApps = {
      "BloonsTD6+" = 1584423325;
      Numbers = 361304891;
      Pages = 409201541;
      Keynote = 361285480;
      "Windows App" = 1295203466;
    };

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
  };
}
