{ pkgs, ... }:
{
  virtualisation.oci-containers.containers.clash = {
    image = "dreamacro/clash-premium";
    user = "root";
    autoStart = true;
    volumes = [
      "/home/rasp/clash-config.yaml:/root/.config/clash/config.yaml"
    ];
    ports = [ "7890:7890" "53:53" "9090:9090" ];
  };
}

