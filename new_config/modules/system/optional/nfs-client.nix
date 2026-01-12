{ config, lib, ... }:

let
  cfg = config.myOptions.networking.nfs;
in
{
  # Create filesystem mounts for each NFS share
  fileSystems = lib.mapAttrs' (name: share:
    lib.nameValuePair share.mountPoint {
      device = "${share.server}:${share.remotePath}";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=${toString share.idleTimeout}"
      ];
    }
  ) cfg.shares;
}
