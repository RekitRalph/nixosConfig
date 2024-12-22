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

  # allow app-image programs to run. 
  programs.appimage.binfmt = true;
  
}
