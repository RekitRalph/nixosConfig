{ pkgs, config, libs, ... }:

{
# Enable the X11 windowing system. and Gnome Desktop

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true; # Start in X11 = false
    desktopManager.gnome.enable = true;
  };

  services.displayManager.defaultSession = "gnome";
  programs.dconf.enable = true;

  # Tweaks
  services.gnome.core-utilities.enable = false;

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
    pop-shell
  ]);

}
