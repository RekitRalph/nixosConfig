# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-stable, ... }:

{

 nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # ./../../modules/nvidia.nix
    # ./../../modules/gaming.nix
    # ./../../modules/gnome.nix
    ./../../modules/vm.nix
    # ./../../modules/home/themes.nix
    ./../../modules/hyprland.nix
    # ./../../modules/xfce.nix
  ];

  networking.hostName = "lappy"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 2;

    # Limit the number of generations to keep
    systemd-boot.configurationLimit = 10;
  };

  # Change the Kernel to xanmod
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.printing.drivers = [ pkgs.hplip pkgs.hplipWithPlugin ];

  # Autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  # disable firewall
  networking.firewall.enable = false;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.evan = {
    isNormalUser = true;
    description = "evan";
    extraGroups = [ "networkmanager" "wheel" ];
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

  services.samba = { enable = true; };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # enable flatpak
  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
    aaxtomp3
    audible-cli
    bitwarden-desktop
    bibata-cursors # cursor theme (Bibata-Original-Ice)
    btop
    calibre # ebooks
    discord
    eza # ls replacement
    fd # find replacement
    fzf # fuzzy finder
    fastfetch # terminal print specs
    filezilla
    git
    gparted
    helix # code editor
    htop
    kitty # terminal
    libgourou # remove ACSM drm
    libreoffice-fresh # office suite
    mumble
    mupdf
    p7zip
    pavucontrol
    qimgv
    unetbootin
    ungoogled-chromium # browser
    usbutils
    veracrypt # encrypted file archive
    vlc
    vscodium # code editor
    wget
    wl-clipboard
    xclip
    wlvncc # wayland vnc client
    youtube-music    
    yazi # terminal file browser
    dracula-theme # color theme
    dracula-icon-theme # Icon theme
    selectdefaultapplication
    tealdeer
    foot
  ]) ++ (with pkgs-stable; [
    # calibre # use stable version of calibre
  ]);


  # Install firefox.
  programs.firefox.enable = true;

 # VS Codium direnv
 programs.direnv.enable = true;

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    corefonts
    google-fonts
    font-awesome
    dejavu_fonts
    vistafonts
    nerd-font-patcher
    (nerdfonts.override { fonts = [ "JetBrainsMono" "NerdFontsSymbolsOnly" ]; })
  ];

  # Enable LocalSend to send files from phone to computer.
  programs.localsend.enable = true;

  # Enable Thunar file manager
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [thunar-volman];
  };
  services.gvfs.enable = true; # mount usb with thunar
  
  # Udev rules for usb connect on browser
  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a878", MODE:="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a878", MODE:="0660", GROUP="input"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a879", MODE:="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a879", MODE:="0660", GROUP="input"
  '';

  # NFS Share from debian server
  fileSystems."/mnt/nfs_media" = {
    device = "192.168.1.132:/mnt/nfsshare/";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
  };

  # pulseaudio support for Mumble
  # environment.systemPackages = [(pkgs.mumble.override { pulseSupport = true; })];

  system.stateVersion = "24.05"; # Did you read the comment?

}
