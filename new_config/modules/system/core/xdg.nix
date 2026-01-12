{ pkgs, ... }:

{
  # XDG portal configuration
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "*";

  # AppImage support
  programs.appimage.binfmt = true;
}
