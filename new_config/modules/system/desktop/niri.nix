{ config, pkgs, ... }:

{
  programs.niri.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = { };

  environment.systemPackages = with pkgs; [
    fuzzel
    swaylock
    mako
    swayidle
    xwayland-satellite
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    playerctl
    matugen
  ];

  # Systemd user service for idle timeout
  systemd.user.services.swayidle = {
    description = "Idle manager for Niri";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.swayidle}/bin/swayidle -w \
          timeout 600 '${pkgs.niri}/bin/niri msg action power-off-monitors' \
          resume '${pkgs.niri}/bin/niri msg action power-on-monitors' \
          timeout 900 '${pkgs.swaylock}/bin/swaylock -f' \
          before-sleep '${pkgs.swaylock}/bin/swaylock -f'
      '';
      Restart = "on-failure";
    };
  };
}
