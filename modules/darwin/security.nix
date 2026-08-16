_: {
  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
  };

  networking.applicationFirewall = {
    enable = true;
    enableStealthMode = true;

    allowSigned = true;
    allowSignedApp = true;

    blockAllIncoming = false;
  };
}
