{ config, pkgs, pkgs-stable, ... }:
{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [

    bitwarden-desktop
    youtube-music
    calibre # ebooks
    vesktop # discord replacement
    discord
    # libreoffice-fresh # office suite
    mumble
    veracrypt # encrypted file archive
    vlc
    ungoogled-chromium # browser
    qbittorrent
    protonvpn-gui
    #ivpn-ui
    picocrypt # encryption file tool, alternative to veracrypt
    # kmymoney # Personal finance program
    realvnc-vnc-viewer
    nautilus # Gnome File manager
    rhythmbox # Music player
    conky
    zed-editor-fhs

    # terminal #
    eza # ls replacement
    fd # find replacement
    fzf # fuzzy finder
    bat # cat replacement
    wget
    wl-clipboard # wayland clipboard
    xclip # x clipboard
    yazi # terminal file browser
    tealdeer # tldr for man pages
    btop # system monitor
    htop
    git
    fastfetch # terminal print specs
    p7zip
    libgourou # remove ACSM drm
    zip
    xz
    unzip
    pandoc # convert to markdown format
    lazygit # git gui
    file-roller
    appimage-run # appimage interpreter
    zoxide
    nvd
    qdirstat # disk usage analyzer
    # pywal16 # color generator based off walpaper

    gparted
    gedit # text editor
    kitty # terminal
    qpdfview # pdf reader
    qimgv # image viewer qt5
    unetbootin # create usb iso
    vscodium # code editor
    pavucontrol
    usbutils
    solaar # logitech manager
    scrcpy # android screen mirror
    helix # text editor 
    lm_sensors # sensor for fan control
    lact # amd configure
    micro # nano replacement text editor

    # Helix languages
    nil
    taplo
    vscode-langservers-extracted
    nixpkgs-fmt
    kdlfmt


    selectdefaultapplication # set default apps for files
    filezilla
    wlvncc # wayland vnc client
    linuxKernel.packages.linux_xanmod_latest.nct6687d
    # Theme #
    bibata-cursors # cursor theme (Bibata-Original-Ice)
    dracula-theme # color theme
    dracula-icon-theme # Icon theme
    hackneyed # windows 3.x cursor theme
    posy-cursors # posy cursors from youtube
    tokyonight-gtk-theme #Tokyo Night color theme
    colloid-gtk-theme # Colloid color theme

  ]) ++ (with pkgs-stable; [
    # calibre # use stable version of calibre
    libreoffice-fresh
    xfce.thunar
    # wpsoffice
  ]);


  # VS Codium direnv
  programs.direnv.enable = true;
  # Mullvad VPN
  services.mullvad-vpn.enable = true;
  # services.mullvad-vpn.packages = {pkgs.mullvad-vpn;

  # fan control software
  # programs.coolercontrol.enable = true;


  # Enable LocalSend to send files from phone to computer.
  programs.localsend.enable = true;


}
