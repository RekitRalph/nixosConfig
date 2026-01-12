{ config, pkgs, ... }:

{
  # Placeholder for NVIDIA GPU support
  hardware.graphics = {
    enable = true;
    enable32Bit = config.myOptions.hardware.gpu.enable32Bit;
  };
}
