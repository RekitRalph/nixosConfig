{ config, lib, ... }:

let
  cfg = config.myOptions;
in
{
  imports = [
    (lib.mkIf cfg.features.gaming.enable ./gaming.nix)
    (lib.mkIf cfg.features.virtualization.enable ./virtualization.nix)
    (lib.mkIf cfg.features.mouseAccel.enable ./mouse-accel.nix)
    (lib.mkIf cfg.features.tailscale.enable ./tailscale.nix)
    (lib.mkIf cfg.features.flatpak.enable ./flatpak.nix)
    (lib.mkIf cfg.networking.nfs.enable ./nfs-client.nix)
    (lib.mkIf cfg.networking.samba.enable ./samba.nix)
    (lib.mkIf cfg.home.enablePywal ./pywal.nix)
  ];
}
