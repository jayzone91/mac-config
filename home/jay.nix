{pkgs, ...}:

{
  imports = [
  ./modules/shell.nix
  ./modules/starship.nix
  ./modules/cli.nix
  ./modules/neovim.nix
  ./modules/ghostty.nix
  ];

  home = {
    stateVersion = "26.05";

    packages = [
      pkgs.fd
      pkgs.ripgrep
      pkgs.just
    ];
  };

  programs = {
    man = {
      enable = true;
      package = pkgs.man;
      generateCaches = true;
    };
  };
}
