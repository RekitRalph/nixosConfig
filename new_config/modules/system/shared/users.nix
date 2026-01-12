{ config, ... }:

let
  cfg = config.myOptions.user;
in
{
  users.users.${cfg.username} = {
    isNormalUser = true;
    description = cfg.fullName;
    extraGroups = cfg.groups;
  };

  services.displayManager.autoLogin = {
    enable = cfg.autoLogin;
    user = cfg.username;
  };

  # State version
  system.stateVersion = config.myOptions.system.stateVersion;
}
