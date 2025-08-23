{pkgs, host, ...}:
{
  # disable firewall
  networking.firewall.enable = false;

  services.samba = { enable = true; };

  # NFS Share from debian server
  fileSystems."/mnt/nfs_media" = {
    device = "192.168.1.132:/mnt/nfsshare/";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
  };

  services.ivpn.enable = true;
}
