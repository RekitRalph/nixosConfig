{ config, pkgs, ... }:
{
    #to enable Hyprland
    programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # nvidiaPatches = true;
    };

    services.hypridle.enable = true;
    


    environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint Electon apps to use wayland
    NIXOS_OZONE_WL = "1";
    };

    hardware = {
        # Opengl
        graphics.enable = true;
        #Most wayland compositors need this
        nvidia.modesetting.enable = true;
    };

    #For screen sharing
    services.dbus.enable = true;
    xdg.portal.enable = true;
    xdg.portal.wlr.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];


    environment.systemPackages = with pkgs; [
    waybar #top bar
    swww # for wallpapers
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    gvfs # virtual filesystem support Calibre
    xwayland
    nwg-look
    wofi #menu
    dunst #notification daemon
    libnotify
    meson
    wayland-protocols
    wayland-utils
    wl-clipboard #clipboard
    wlroots
    swayimg #img viewer
    polkit
    hyprcursor
    hyprgui
    ];
    #enable security prompts
    security.polkit.enable = true;

    #to fix waybar not displaying Hyprland workspaces
    nixpkgs.overlays = [
    (self: super: {
    waybar = super.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
            });
        })
    ];
}
