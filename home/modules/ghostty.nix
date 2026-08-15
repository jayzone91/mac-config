_:

{
  program.ghostty = {
    enable = true;
    package = null;

    settings = {
      font-size = 14;
      
      theme = "light:catppuccin-latte,dark:catppuccin-mocha";

      window-padding-x = 10;
      window-padding-y = 8;
      window-padding-balace = true;

      macos-titlebar-style = "transparent";

      shell_integration = "detect";

      window-inherit-working-directory = true;
      tab-inherit-working-directory = true;
      split-inherit-working-directory = true;

      mouse-hide-while-typing = true;

      copy-on-select = false;

      conform-close-surface = false;
    };
  };
}
