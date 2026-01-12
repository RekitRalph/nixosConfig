{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  myOptions = {
    # System Identity
    system.hostname = "starchy";
    system.stateVersion = "24.05";

    # User Configuration
    user = {
      username = "evan";
      fullName = "evan";
      groups = [ "networkmanager" "wheel" "audio" "uucp" "dialout" "libvirtd" ];
      autoLogin = true;
    };

    # Desktop Environment
    desktop = {
      enable = true;
      environment = "kde";
      wayland = true;
    };

    # Hardware Configuration
    hardware = {
      gpu = {
        vendor = "amd";
        enable32Bit = true;  # For gaming
      };
      cpu.vendor = "amd";
      laptop.enable = false;
    };

    # Optional Features
    features = {
      gaming.enable = true;
      virtualization = {
        enable = true;
        waydroid = false;
      };
      mouseAccel.enable = false;
      tailscale.enable = false;
      flatpak = {
        enable = true;
        enableBeta = true;
      };
    };

    # Networking
    networking = {
      firewall.enable = false;
      samba.enable = true;
      nfs = {
        enable = true;
        shares.media = {
          server = "192.168.1.132";
          remotePath = "/mnt/nfsshare/";
          mountPoint = "/mnt/nfs_media";
          idleTimeout = 600;
        };
      };
    };

    # Locale
    locale = {
      timeZone = "America/Chicago";
      defaultLocale = "en_US.UTF-8";
      extraLocale = "en_US.UTF-8";
      keyboardLayout = "us";
    };

    # Appearance
    appearance.cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Ice";
      size = 24;
    };

    # Storage
    storage = {
      zramSwap = true;
      garbageCollection = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      extraMounts = {
        misc = {
          device = "/dev/disk/by-uuid/c4ed7cf6-09dd-4778-b65d-3aa1099ec134";
          fsType = "ext4";
        };
        virt = {
          device = "/dev/disk/by-uuid/f16ce643-90c2-4af1-a1ee-e9229bbf4f69";
          fsType = "ext4";
        };
      };
    };

    # Boot Configuration
    boot = {
      timeout = 2;
      configurationLimit = 10;
      kernel = "cachyos-lto";
      extraParams = [ "usbcore.quirks=0853:0317:gki" ];
    };

    # Special Hardware
    specialHardware = {
      amdGpu = {
        enableOverdrive = true;
        enableLact = true;
      };
      udevRules = ''
        SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a878", MODE:="0777"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a878", MODE:="0777"
        SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a879", MODE:="0777"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a879", MODE:="0777"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="104d", MODE:="0777"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="320f", ATTRS{idProduct}=="5055", MODE:="0777"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="33e4", ATTRS{idProduct}=="3517", MODE:="0777"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="33e4", ATTRS{idProduct}=="3508", MODE:="0777"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="0853", ATTRS{idProduct}=="0317", MODE:="0660", GROUP="input", TAG+="uaccess"
        SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0853", ATTRS{idProduct}=="0317", MODE:="0660", GROUP="input", TAG+="uaccess"
      '';
    };
  };

  # Apply extra mounts
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
