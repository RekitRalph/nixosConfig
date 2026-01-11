{ config, pkgs, ... }:
{
  # Enable Thunar file manager
  programs.thunar = {
    enable = true;
    # plugins = with pkgs.xfce; [ thunar-volman thunar-archive-plugin ];
  };

  # plugins for thunar
  pkgs.thunar-volman = true;
  pkgs.thunar-archive-plugin = true;

  services.gvfs.enable = true; # mount usb with thunar
}
