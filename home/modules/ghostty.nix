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

      shell-integration = "detect";

      window-inherit-working-directory = true;
      tab-inherit-working-directory = true;
      split-inherit-working-directory = true;

      mouse-hide-while-typing = true;

      copy-on-select = false;

      confirm-close-surface = false;
    };
  };
}
