{ lib, pkgs, ... }:

{
  options.myOptions = with lib; {

    # ========== USER CONFIGURATION ==========
    user = {
      username = mkOption {
        type = types.str;
        default = "evan";
        description = "Primary user account name";
      };

      fullName = mkOption {
        type = types.str;
        default = "evan";
        description = "Full name for user account";
      };

      groups = mkOption {
        type = types.listOf types.str;
        default = [ "networkmanager" "wheel" ];
        description = "Additional groups for the user";
      };

      autoLogin = mkOption {
        type = types.bool;
        default = true;
        description = "Enable automatic login";
      };
    };

    # ========== SYSTEM IDENTITY ==========
    system = {
      hostname = mkOption {
        type = types.str;
        example = "starchy";
        description = "System hostname";
      };

      stateVersion = mkOption {
        type = types.str;
        default = "24.05";
        description = "NixOS state version";
      };
    };

    # ========== DESKTOP ENVIRONMENT ==========
    desktop = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable desktop environment";
      };

      environment = mkOption {
        type = types.enum [ "kde" "gnome" "hyprland" "niri" "cosmic" "xfce" "none" ];
        default = "none";
        example = "kde";
        description = "Desktop environment to use";
      };

      displayManager = mkOption {
        type = types.enum [ "sddm" "gdm" "ly" "auto" ];
        default = "auto";
        description = "Display manager (auto = choose based on desktop)";
      };

      wayland = mkOption {
        type = types.bool;
        default = true;
        description = "Prefer Wayland over X11 where applicable";
      };
    };

    # ========== HARDWARE CONFIGURATION ==========
    hardware = {
      gpu = {
        vendor = mkOption {
          type = types.enum [ "amd" "nvidia" "intel" "none" ];
          default = "none";
          example = "amd";
          description = "GPU vendor for hardware acceleration";
        };

        enable32Bit = mkOption {
          type = types.bool;
          default = false;
          description = "Enable 32-bit graphics libraries (needed for gaming)";
        };

        nvidia = {
          prime = mkOption {
            type = types.bool;
            default = false;
            description = "Enable NVIDIA Prime for hybrid graphics";
          };
        };
      };

      cpu = {
        vendor = mkOption {
          type = types.enum [ "amd" "intel" ];
          default = "amd";
          description = "CPU vendor for microcode";
        };
      };

      laptop = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = "Enable laptop-specific features (power management, battery)";
        };
      };
    };

    # ========== OPTIONAL FEATURES ==========
    features = {
      gaming = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = "Enable gaming support (Steam, Lutris, etc)";
        };
      };

      virtualization = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = "Enable virtualization (libvirt, virt-manager)";
        };

        waydroid = mkOption {
          type = types.bool;
          default = false;
          description = "Enable Waydroid Android emulation";
        };
      };

      mouseAccel = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = "Enable maccel custom mouse acceleration";
        };
      };

      tailscale = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = "Enable Tailscale VPN";
        };

        port = mkOption {
          type = types.int;
          default = 41641;
          description = "Tailscale listen port";
        };
      };

      flatpak = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable Flatpak support";
        };

        enableBeta = mkOption {
          type = types.bool;
          default = false;
          description = "Add Flathub Beta repository";
        };
      };
    };

    # ========== NETWORKING ==========
    networking = {
      firewall = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable firewall (recommended)";
        };
      };

      samba = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = "Enable Samba client";
        };
      };

      nfs = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = "Enable NFS client mounts";
        };

        shares = mkOption {
          type = types.attrsOf (types.submodule {
            options = {
              server = mkOption {
                type = types.str;
                example = "192.168.1.132";
                description = "NFS server IP or hostname";
              };

              remotePath = mkOption {
                type = types.str;
                example = "/mnt/nfsshare/";
                description = "Remote NFS export path";
              };

              mountPoint = mkOption {
                type = types.str;
                example = "/mnt/nfs_media";
                description = "Local mount point";
              };

              idleTimeout = mkOption {
                type = types.int;
                default = 600;
                description = "Idle timeout in seconds for automount";
              };
            };
          });
          default = {};
          description = "NFS shares to mount";
        };
      };
    };

    # ========== LOCALE & REGIONAL ==========
    locale = {
      timeZone = mkOption {
        type = types.str;
        default = "America/Chicago";
        description = "System timezone";
      };

      defaultLocale = mkOption {
        type = types.str;
        default = "en_US.UTF-8";
        description = "Default system locale";
      };

      extraLocale = mkOption {
        type = types.str;
        default = "en_US.UTF-8";
        description = "Locale for LC_* variables";
      };

      keyboardLayout = mkOption {
        type = types.str;
        default = "us";
        description = "Keyboard layout";
      };
    };

    # ========== APPEARANCE ==========
    appearance = {
      cursor = {
        package = mkOption {
          type = types.package;
          default = pkgs.bibata-cursors;
          description = "Cursor theme package";
        };

        name = mkOption {
          type = types.str;
          default = "Bibata-Original-Ice";
          description = "Cursor theme name";
        };

        size = mkOption {
          type = types.int;
          default = 24;
          description = "Cursor size in pixels";
        };
      };

      stylix = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = "Enable Stylix theming system";
        };
      };
    };

    # ========== STORAGE & PERFORMANCE ==========
    storage = {
      zramSwap = mkOption {
        type = types.bool;
        default = false;
        description = "Enable zram swap";
      };

      garbageCollection = {
        automatic = mkOption {
          type = types.bool;
          default = true;
          description = "Enable automatic garbage collection";
        };

        dates = mkOption {
          type = types.str;
          default = "weekly";
          description = "When to run garbage collection";
        };

        options = mkOption {
          type = types.str;
          default = "--delete-older-than 7d";
          description = "Garbage collection options";
        };
      };

      extraMounts = mkOption {
        type = types.attrsOf (types.submodule {
          options = {
            device = mkOption {
              type = types.str;
              description = "Device path or UUID";
            };

            fsType = mkOption {
              type = types.str;
              default = "ext4";
              description = "Filesystem type";
            };

            options = mkOption {
              type = types.listOf types.str;
              default = [ "nofail" ];
              description = "Mount options";
            };
          };
        });
        default = {};
        description = "Additional filesystem mounts";
      };
    };

    # ========== BOOT CONFIGURATION ==========
    boot = {
      timeout = mkOption {
        type = types.int;
        default = 5;
        description = "Bootloader timeout in seconds";
      };

      configurationLimit = mkOption {
        type = types.int;
        default = 10;
        description = "Number of generations to keep in bootloader";
      };

      kernel = mkOption {
        type = types.enum [ "cachyos-lto" "cachyos" "xanmod" "latest" "default" ];
        default = "default";
        description = "Kernel variant to use";
      };

      extraParams = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Extra kernel parameters";
      };
    };

    # ========== SPECIAL HARDWARE ==========
    specialHardware = {
      amdGpu = {
        enableOverdrive = mkOption {
          type = types.bool;
          default = false;
          description = "Enable AMD GPU overdrive for overclocking";
        };

        enableLact = mkOption {
          type = types.bool;
          default = false;
          description = "Enable LACT AMD GPU control";
        };
      };

      udevRules = mkOption {
        type = types.lines;
        default = "";
        description = "Custom udev rules for special hardware";
      };
    };

    # ========== HOME-MANAGER OPTIONAL MODULES ==========
    home = {
      enableOhMyPosh = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Oh My Posh shell prompt theming";
      };

      enableStylix = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Stylix system-wide theming (base16)";
      };

      enableGtkTheme = mkOption {
        type = types.bool;
        default = false;
        description = "Enable GTK/Qt theming with Dracula";
      };

      enablePywal = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Pywal color scheme generator";
      };

      enableHelix = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Helix editor configuration";
      };
    };
  };
}
