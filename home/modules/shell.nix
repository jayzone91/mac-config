_:

{
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

        nrs = "sudo darwin-rebuild switch --flake ~/Documents/GitHub/mac-config#MacbookPro";
        nfc = "nix flake check ~/Documents/GitHub/mac-config";
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
