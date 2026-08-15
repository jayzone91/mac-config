{ ... }:

{
  system.stateVersion = 6;
  system.primaryUser = "jay";

  users.users.jay = {
    home = "/Users/jay";
  };

  networking.hostName = "MacbookPro";
  networking.localHostName = "MacbookPro";
}
