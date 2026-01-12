{ config, lib, ... }:

let
  cfg = config.myOptions.desktop;
in
{
  # Desktop environment routing - modules will be added here
  imports = lib.optionals cfg.enable (
    if cfg.environment == "kde" then [ ./kde.nix ]
    else if cfg.environment == "gnome" then [ ./gnome.nix ]
    else if cfg.environment == "hyprland" then [ ./hyprland.nix ]
    else if cfg.environment == "niri" then [ ./niri.nix ]
    else if cfg.environment == "cosmic" then [ ./cosmic.nix ]
    else if cfg.environment == "xfce" then [ ./xfce.nix ]
    else if cfg.environment == "none" then []
    else throw "Unknown desktop environment: ${cfg.environment}"
  );
}
