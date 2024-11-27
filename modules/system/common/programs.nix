{config, pkgs, pkgs-stable, ...}:
{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [

    bitwarden-desktop
    youtube-music    
    calibre # ebooks
    discord
    # libreoffice-fresh # office suite
    mumble
    veracrypt # encrypted file archive
    vlc
    ungoogled-chromium # browser

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
    pandoc
    lazygit

    gparted
    gedit # text editor
    kitty # terminal
    mupdf # pdf reader
    qimgv # image viewer qt5
    unetbootin # create usb iso
    vscodium # code editor
    pavucontrol
    usbutils
    hugo

   
    selectdefaultapplication # set default apps for files
    filezilla
    wlvncc # wayland vnc client

    # Theme #
    bibata-cursors # cursor theme (Bibata-Original-Ice)
    dracula-theme # color theme
    dracula-icon-theme # Icon theme

  ]) ++ (with pkgs-stable; [
    # calibre # use stable version of calibre
    #libreoffice-fresh 
  ]);


  # VS Codium direnv
  programs.direnv.enable = true;



  # Enable LocalSend to send files from phone to computer.
  programs.localsend.enable = true;


}