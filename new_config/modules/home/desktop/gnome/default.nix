{ pkgs, ... }:

{
  imports = [
    ./dconf.nix
  ];

  # GNOME-specific packages
  home.packages = with pkgs; [
    dconf-editor
    gnome-tweaks
  ];
}
