{ pkgs, ... }:

{
  # Starchy-specific packages and configuration
  home.packages = with pkgs; [
    # Gaming tools (only on starchy)
    mangohud
    goverlay

    # VM tools
    virt-manager
  ];
}
