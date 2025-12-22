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
  boot.kernelPackages = inputs.nix-cachyos-kernel.legacyPackages.${config.nixpkgs.system}.linuxPackages-cachyos-latest-lto;
  #boot.kernelPackages = pkgs.linuxPackages_latest; # regular kernel
  boot.kernelParams = [
    "usbcore.quirks=0853:0317:gki" # fix for keyboard not working after boot

    # # Temporary fix for amdgpu flip_done timeout errors
    # "amdgpu.dpm=0"      # Disable dynamic power management
    # "amdgpu.aspm=0"     # Disable active state power management
    # "amdgpu.bapm=0"     # Disable bidirectional application power management
    # "amdgpu.runpm=0"    # Disable runtime power management
    # "pcie_aspm=off"     # Disable PCIe active state power management
  ];

  # boot.extraModulePackages = with config.boot.kernelPackages; [ nct6687d ];
  boot.kernelModules = [ "nct6687d" ];
}
