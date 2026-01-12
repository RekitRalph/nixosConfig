{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  myOptions = {
    # System Identity
    system.hostname = "lappy";
    system.stateVersion = "24.05";

    # User Configuration
    user = {
      username = "evan";
      fullName = "evan";
      groups = [ "networkmanager" "wheel" ];
      autoLogin = true;
    };

    # Desktop Environment
    desktop = {
      enable = true;
      environment = "gnome";
      wayland = true;
    };

    # Hardware Configuration
    hardware = {
      gpu = {
        vendor = "intel";
        enable32Bit = false;
      };
      cpu.vendor = "intel";
      laptop.enable = true;  # Laptop-specific features
    };

    # Optional Features
    features = {
      gaming.enable = false;  # Not enabled on laptop
      virtualization = {
        enable = false;
        waydroid = false;
      };
      mouseAccel.enable = false;
      tailscale = {
        enable = true;
        port = 12345;
      };
      flatpak = {
        enable = true;
        enableBeta = false;  # Only stable on laptop
      };
    };

    # Networking
    networking = {
      firewall.enable = true;  # Firewall enabled on laptop
      samba.enable = false;
      nfs.enable = false;  # No NFS on laptop
    };

    # Locale (same as desktop)
    locale = {
      timeZone = "America/Chicago";
      defaultLocale = "en_US.UTF-8";
      extraLocale = "en_US.UTF-8";
      keyboardLayout = "us";
    };

    # Appearance (consistent cursor)
    appearance.cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Ice";
      size = 24;
    };

    # Storage
    storage = {
      zramSwap = false;  # Not enabled on laptop
      garbageCollection = {
        automatic = false;
        dates = "weekly";
        options = "--delete-older-than 1w";
      };
      extraMounts = {};  # No extra mounts on laptop
    };

    # Boot Configuration
    boot = {
      timeout = 5;  # Default timeout
      configurationLimit = 10;
      kernel = "default";  # Using default kernel on laptop
      extraParams = [];
    };

    # Special Hardware
    specialHardware = {
      amdGpu = {
        enableOverdrive = false;
        enableLact = false;
      };
      udevRules = ''
        SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a878", MODE:="0660", GROUP="input"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a878", MODE:="0660", GROUP="input"
        SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a879", MODE:="0660", GROUP="input"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a879", MODE:="0660", GROUP="input"
      '';
    };
  };

  # Apply extra mounts (empty for lappy)
  fileSystems = builtins.mapAttrs (name: mount: {
    device = mount.device;
    fsType = mount.fsType;
    options = mount.options;
  }) config.myOptions.storage.extraMounts;

  # Apply zram swap
  zramSwap.enable = config.myOptions.storage.zramSwap;

  # Apply udev rules
  services.udev.extraRules = config.myOptions.specialHardware.udevRules;
}
