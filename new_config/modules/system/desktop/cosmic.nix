{ config, ... }:

let
  cfg = config.myOptions;
in
{
  # Enable the COSMIC login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;

  # FIX: Use myOptions instead of hardcoded username
  services.displayManager.autoLogin = {
    enable = cfg.user.autoLogin;
    user = cfg.user.username;
  };
}
