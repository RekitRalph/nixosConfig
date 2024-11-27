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

}