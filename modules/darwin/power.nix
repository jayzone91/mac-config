_:

{
  system.activationScripts.postActivation.text = ''
    /usr/bin/pmset -b \
      displaysleep 5 \
      sleep 10 \
      powernap 0 \
      womp 0 \
      tcpkeepalive 1 \
      lowpowermode 0

    /usr/bin/pmset -c \
      displaysleep 15 \
      sleep 0 \
      powernap 1 \
      womp 1 \
      tcpkeepalive 1 \
      lowpowermode 0
    '';
}
