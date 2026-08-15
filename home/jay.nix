{config, pkgs, inputs, ...}:

{
  home = {
    stateVersion = "26.05";

    packages = [
      inputs.neovim-nightly.packages.${pkgs.stdenv.hostPlatform.system}.neovim
      
      pkgs.fd
      pkgs.ripgrep
    ];

    file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/Users/jay/Documents/GitHub/nvim";
  };

  programs = {
    man = {
      enable = true;
      package = pkgs.man;
      generateCaches = true;
    };
  };
}
