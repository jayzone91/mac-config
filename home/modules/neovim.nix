{config, pkgs, inputs, ...}:

{
  home = {
    packages = [
      inputs.neovim-nightly.packages.${pkgs.stdenv.hostPlatform.system}.neovim
    ];

    file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/Users/jay/Documents/GitHub/nvim";
  };
}
