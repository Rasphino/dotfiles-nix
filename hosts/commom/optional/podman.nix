{ lib, ... }: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = false;
    dockerSocket.enable = false;
    defaultNetwork.dnsname.enable = true;
  };
}
