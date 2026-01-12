{ pkgs, ... }:

{
  # PulseAudio config for XFCE
  nixpkgs.config.pulseaudio = true;

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    xfce.xfce4-whiskermenu-plugin
    rofi
    clipman
  ];

  services.displayManager.defaultSession = "xfce";
}
