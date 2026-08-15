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
    fish = {
      enable = true;

      interactiveShellInit = ''
        set -g fish_greeting
        set -gx EDITOR nvim
        set -gx VISUAL nvim
      '';

      shellAbbrs = {
        g = "git"; 
        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gl = "git pull";
        gd = "git diff";

        ll = "eza -lah --group-directories-first";
        la = "eza -a";

        nrs = "sudo darwin-rebiuld switch --flake ~/Documents/GitHub/mac-config#MacbookPro";
        nfc = "nix flake check ~/Documents/GitHub/mac-config";
      };
    };

    man = {
      enable = true;
      package = pkgs.man;
      generateCaches = true;
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
      git = true;
      icons = "auto";
    };

    bat.enable = true;
  };
}
