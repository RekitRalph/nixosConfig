{ config, ... }:

let
  cfg = config.myOptions;
in
{
  networking.hostName = cfg.system.hostname;
  networking.networkmanager.enable = true;
  networking.firewall.enable = cfg.networking.firewall.enable;
}
