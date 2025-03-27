{config, pkgs, ...}:
{
  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.printing.drivers = [ pkgs.hplip pkgs.hplipWithPlugin ];

  # Autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
