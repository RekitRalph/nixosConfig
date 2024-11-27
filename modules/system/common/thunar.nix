{config, pkgs, ...}:
{
    # Enable Thunar file manager
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [thunar-volman];
  };

  services.gvfs.enable = true; # mount usb with thunar
}