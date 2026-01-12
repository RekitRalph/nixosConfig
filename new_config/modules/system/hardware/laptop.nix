{ ... }:

{
  # Laptop-specific power management
  services.thermald.enable = true;
  services.tlp.enable = true;
  powerManagement.enable = true;
}
