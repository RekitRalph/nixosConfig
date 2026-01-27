{ config, pkgs, ... }:
{
  # Enable Thunar file manager
  programs.thunar = {
    enable = true;
    # plugins = with pkgs.xfce; [ thunar-volman thunar-archive-plugin ];
  };

  # plugins for thunar
  enviroment.systemPackages = with pkgs; [
    thunar-archive-plugin
    thunar-volman
  ];

  services.gvfs.enable = true; # mount usb with thunar
}
