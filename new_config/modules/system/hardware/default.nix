{ config, lib, ... }:

let
  cfg = config.myOptions.hardware;
in
{
  imports = [
    (lib.mkIf (cfg.gpu.vendor == "amd") ./amd-gpu.nix)
    (lib.mkIf (cfg.gpu.vendor == "intel") ./intel-gpu.nix)
    (lib.mkIf (cfg.gpu.vendor == "nvidia") ./nvidia-gpu.nix)
    (lib.mkIf cfg.laptop.enable ./laptop.nix)
  ];
}
