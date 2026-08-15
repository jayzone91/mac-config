_:
{
  system.defaults.SoftwareUpdate = {
    AutomaticallyInstallMacOSUpdates = true;
  };

  system.defaults.CustomSystemPreferences = {
    "com.apple.SoftwareUpdate" = {
      AutomaticCheckEnabled = true;
      AutomaticDownload = true;
      CriticalUpdateInstall = true;
      ConfigDataInstall = true;
    };

    "com.apple.commerce" = {
      AutoUpdate = true;
    };
  };
}
