{ config, pkgs, inputs, lib, ... }:

let
  cfg = config.myOptions;
in
{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = cfg.boot.timeout;
    systemd-boot.configurationLimit = cfg.boot.configurationLimit;
  };

  # Kernel selection based on myOptions
  boot.kernelPackages =
    if cfg.boot.kernel == "cachyos-lto" then
      inputs.nix-cachyos-kernel.legacyPackages.${config.nixpkgs.system}.linuxPackages-cachyos-latest-lto
    else if cfg.boot.kernel == "cachyos" then
      inputs.nix-cachyos-kernel.legacyPackages.${config.nixpkgs.system}.linuxPackages-cachyos-latest
    else if cfg.boot.kernel == "xanmod" then
      pkgs.linuxPackages_xanmod_latest
    else if cfg.boot.kernel == "latest" then
      pkgs.linuxPackages_latest
    else
      pkgs.linuxPackages;

  boot.kernelParams = cfg.boot.extraParams;

  # NCT6687D sensor module for monitoring
  boot.kernelModules = [ "nct6687d" ];
}
