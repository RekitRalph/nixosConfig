{ config, lib, pkgs, ... }:

let
  cfg = config.myOptions;
  username = cfg.user.username;
in
{
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
    adwaita-icon-theme
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
    };
    spiceUSBRedirection.enable = true;
  };

  services.spice-vdagentd.enable = true;

  # Optional Waydroid
  virtualisation.waydroid.enable = cfg.features.virtualization.waydroid;
}
