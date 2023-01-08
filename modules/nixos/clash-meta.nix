{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.clash-meta;

in
{
  options.services.clash-meta = {
    enable = mkEnableOption "Enable Clash.Meta service";
    package = mkOption {
      type = types.package;
      default = pkgs.clash-meta;
      defaultText = "pkgs.clash-meta";
      description = lib.mdDoc ''
        Which Clash.Meta package to use.
      '';
    };

    configFile = mkOption {
      type = types.str;
      example = "/etc/clash-meta/config.yaml";
      description = lib.mdDoc ''
        The absolute path to Clash.Meta's configuration file.
      '';
    };
    # configDirPath = mkOption {};
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = [ cfg.package ];

    environment.etc."clash-meta/config.yaml".source = cfg.configFile;

    systemd.services.clash-meta = {
      description = "Clash.Meta Daemon, Another Clash Kernel.";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        CapabilityBoundingSet = [ "cap_net_admin" "cap_net_bind_service" ];
        AmbientCapabilities = [ "cap_net_admin" "cap_net_bind_service" ];
        ExecStart = "${cfg.package}/bin/clash-meta -d /etc/clash-meta";
        Restart = "on-abort";
      };
    };
  };

  meta = {
    maintainers = with lib.maintainers; [ misterio77 ];
  };
}

