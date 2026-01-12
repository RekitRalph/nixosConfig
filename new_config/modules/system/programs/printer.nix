{ pkgs, ... }:

{
  # Printer support
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ brlaser ];
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
}
