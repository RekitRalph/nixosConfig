{ pkgs, config, libs, ... }:
{
  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true;
  };



  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    lutris
    heroic
    protontricks
    ryubing
    mangohud
    goverlay
  ];
}
