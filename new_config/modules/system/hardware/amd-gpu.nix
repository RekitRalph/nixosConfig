{ config, pkgs, ... }:

let
  cfg = config.myOptions;
in
{
  hardware.graphics = {
    enable = true;
    enable32Bit = cfg.hardware.gpu.enable32Bit;
    extraPackages = with pkgs; [
      vulkan-loader
      mesa
      vulkan-validation-layers
    ];
  };

  # AMD-specific services
  services.lact.enable = cfg.specialHardware.amdGpu.enableLact;
  hardware.amdgpu.overdrive.enable = cfg.specialHardware.amdGpu.enableOverdrive;
}
