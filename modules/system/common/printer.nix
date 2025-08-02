{config, pkgs, ...}:
{
  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.printing.drivers = [ 
  pkgs.brlaser # drivers for brother printers
  pkgs.brgenml1lpr
  pkgs.brgenml1cupswrapper
  ];

  # nix shell nixpkgs#system-config-printer for gui cups management.

  # Autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
