{pkgs, ...}:

{
  imports = [
    ./modules/shell.nix
    ./modules/starship.nix
    ./modules/cli.nix
    ./modules/neovim.nix
    ./modules/ghostty.nix
    ./modules/dev-tools.nix
  ];

  home = {
    stateVersion = "26.05";

    packages = [
      pkgs.fd
      pkgs.ripgrep
      pkgs.just
    ];

    file."Pictures/Screenshots/.keep".text = "";
  };

  programs = {
    man = {
      enable = true;
      package = pkgs.man;
      generateCaches = true;
    };
  };
}
