# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-stable, ... }:

{

 nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../modules/system/common
    ./../../modules/system/extra/gaming.nix
    ./../../modules/system/extra/vm.nix
    #./../../modules/system/extra/nvidia.nix  
    
    ./../../modules/system/gnome.nix
    # ./../../modules/system/cosmic.nix
    # ./../../modules/home/themes.nix
    #./../../modules/system/hyprland.nix
    # ./../../modules/xfce.nix
  ];

  networking.hostName = "starchy"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    #automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

/*     programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/user/my-nixos-config";
  }; */

  # Optimize storage
  # You can also manually optimize the store via:
  #    nix-store --optimise
  # Refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.evan = {
    isNormalUser = true;
    description = "evan";
    extraGroups = [ "networkmanager" "wheel" "audio" "uucp" "dialout"]; # uucp and dialout for maxx stick
    packages = with pkgs;
      [
        #  thunderbird
      ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin = {
    enable = true;
    user = "evan";
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "*";

  services.lact.enable = true; # fan control service
  hardware.amdgpu.overdrive.enable = true;

  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # enable flatpak
  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo 
   '';
  };
  
   fileSystems."/media/misc" = {
   device = "/dev/disk/by-uuid/c4ed7cf6-09dd-4778-b65d-3aa1099ec134";
   fsType = "ext4";
   options = [ "nofail"];
 };


  # Udev rules for usb connect on browser on WLMOUSE software
  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a878", MODE:="0777" 
    SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a878", MODE:="0777" 
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a879", MODE:="0777" 
    SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a879", MODE:="0777"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="104d", MODE:="0777"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="320f", ATTRS{idProduct}=="5055", MODE:="0777"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="33e4", ATTRS{idProduct}=="3517", MODE:="0777"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="33e4", ATTRS{idProduct}=="3508", MODE:="0777"
  '';


  # pulseaudio support for Mumble
  # environment.systemPackages = [(pkgs.mumble.override { pulseSupport = true; })];

  system.stateVersion = "24.05"; # Did you read the comment?

}
