{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint Electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  hardware.graphics.enable = true;

  # For screen sharing
  services.dbus.enable = true;
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  environment.systemPackages = with pkgs; [
    hyprpaper
    hyprpanel
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    hyprpolkitagent
    gvfs
    xwayland
    nwg-look
    wofi
    libnotify
    meson
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots
    swayimg
    polkit
    hyprcursor
  ];

  security.polkit.enable = true;

  # Waybar overlay for Hyprland workspaces - moved to overlays/default.nix
}
