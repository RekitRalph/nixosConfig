{ config, pkgs, lib, hostConfig, hostname, ... }:

let
  # Access system options
  myOpts = hostConfig.myOptions;
  desktop = myOpts.desktop.environment;
in
{
  home.username = myOpts.user.username;
  home.homeDirectory = "/home/${myOpts.user.username}";
  home.stateVersion = myOpts.system.stateVersion;

  imports = [
    # Common configuration for all hosts
    ./common

    # Desktop-specific configuration
    (lib.mkIf (desktop == "gnome") ./desktop/gnome)
    (lib.mkIf (desktop == "kde") ./desktop/kde)
    (lib.mkIf (desktop == "hyprland") ./desktop/hyprland)
    (lib.mkIf (desktop == "niri") ./desktop/niri)
    (lib.mkIf (desktop == "cosmic") ./desktop/cosmic)
    (lib.mkIf (desktop == "xfce") ./desktop/xfce)

    # Host-specific profile
    ./profiles/${hostname}.nix
  ];

  # Cursor theme consistent with system settings
  gtk.cursorTheme = {
    package = myOpts.appearance.cursor.package;
    name = myOpts.appearance.cursor.name;
    size = myOpts.appearance.cursor.size;
  };

  programs.home-manager.enable = true;
}
