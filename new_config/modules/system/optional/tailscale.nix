{ config, ... }:

let
  cfg = config.myOptions.features.tailscale;
in
{
  services.tailscale = {
    enable = true;
    port = cfg.port;
  };
}
