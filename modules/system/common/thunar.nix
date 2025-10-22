{ config, pkgs, ... }:
{
  # Enable Thunar file manager
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-volman thunar-archive-plugin ];
  };

  services.gvfs.enable = true; # mount usb with thunar
}
