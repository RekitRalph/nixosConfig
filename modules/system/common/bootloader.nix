{ pkgs, nix-cachyos-kernel, inputs, config, ... }:
{
  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 2;

    # Limit the number of generations to keep
    systemd-boot.configurationLimit = 10;
  };

  # Change the Kernel to xanmod
  # boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.kernelPackages = inputs.nix-cachyos-kernel.legacyPackages.${config.nixpkgs.system}.linuxPackages-cachyos-lts-lto;
  #boot.kernelPackages = pkgs.linuxPackages_latest; # regular kernel

  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "usbcore.quirks=0853:0317:gki" # fix for keyboard not working after boot

    # --- Display / Console ---
    "quiet" # Suppress most boot messages
    "splash" # Show splash screen
    "udev.log_level=3" # Kernel log verbosity (0=silent, 7=debug)
    "vt.global_cursor_default=0" # Hide blinking cursor

    # "amdgpu.dcdebugmask=0x10" # maybe stop monitor freeze

    # # Temporary fix for amdgpu flip_done timeout errors
    # "amdgpu.dpm=0"      # Disable dynamic power management
    # "amdgpu.aspm=0"     # Disable active state power management
    # "amdgpu.bapm=0"     # Disable bidirectional application power management
    # "amdgpu.runpm=0"    # Disable runtime power management
    # "pcie_aspm=off"     # Disable PCIe active state power management
  ];

  boot.plymouth = {
    enable = true;
    theme = "rings"; # or "bgrt", "breeze", "fade-in", "glow", "spinner"etc.
    themePackages = with pkgs; [
      # By default we would install all themes
      (adi1090x-plymouth-themes.override {
        selected_themes = [ "rings" ];
      })
    ];
  };

  # boot.extraModulePackages = with config.boot.kernelPackages; [ nct6687d ];
  boot.kernelModules = [ "nct6687d" ];
}
