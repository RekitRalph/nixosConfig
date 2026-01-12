{ pkgs, ... }:

{
  # Workaround for GNOME autologin
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.defaultSession = "gnome";
  programs.dconf.enable = true;

  # Tweaks - disable bloat
  services.gnome.core-apps.enable = false;

  environment.systemPackages = (with pkgs; [
    dconf-editor
    gnome-tweaks
    gnome-terminal
    gnome-settings-daemon
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator
    dash-to-panel
    dash-to-dock
    extension-list
    tiling-shell
    tiling-assistant
    auto-move-windows
  ]);
}
