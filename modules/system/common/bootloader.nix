{pkgs, ...}:
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
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  #boot.kernelPackages = pkgs.linuxPackages_latest; # regular kernel
  boot.kernelParams = [ "usbcore.quirks=0853:0317:gki" ]; # fix for keyboard not working after boot

  # boot.extraModulePackages = with config.boot.kernelPackages; [ nct6687d ];
  boot.kernelModules = [ "nct6687d" ];
}
