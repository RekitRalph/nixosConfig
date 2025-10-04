{ config, pkgs, ... }:
{

  programs.niri.enable = true;

  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = {};

  programs.waybar.enable = true; # top bar
  environment.systemPackages = with pkgs; [
    fuzzel # menu
    swaylock
    mako # notification
    swayidle
    xwayland-satellite
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
  ];

}
