{config, pkgs, pkgs-stable, ...}:
{
  imports = [
    ./bootloader.nix
    ./firefox.nix
    ./fonts.nix
    ./networking.nix
    ./printer.nix
    ./sound.nix
    ./programs.nix
    ./thunar.nix
  ];
}