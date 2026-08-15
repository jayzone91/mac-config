_:

{
  programs.ghostty = {
    enable = true;
    package = null;

    settings = {
      font-size = 14;
      
      theme = "light:Catppuccin Latte,dark:Catppuccin Mocha";

      window-padding-x = 10;
      window-padding-y = 8;
      window-padding-balance = true;

      macos-titlebar-style = "transparent";
      macos-option-as-alt = "right";

      shell-integration = "detect";

      window-inherit-working-directory = true;
      tab-inherit-working-directory = true;
      split-inherit-working-directory = true;

      mouse-hide-while-typing = true;
      copy-on-select = false;
      confirm-close-surface = false;

      quick-terminal-position = "top";
      quick-terminal-size = "40%";
      quick-terminal-screen = "main";
      quick-terminal-autohide = true;
      quick-terminal-space-behavior = "move";
      quick-terminal-animation-duration = 0.15;

      keybind = [
      "global:ctrl+backquote=toggle_quick_terminal"
      ];
    };
  };
}
