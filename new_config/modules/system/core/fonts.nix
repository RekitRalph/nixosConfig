{ pkgs, ... }:

{
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    corefonts
    google-fonts
    font-awesome
    vista-fonts
    nerd-font-patcher
    atkinson-hyperlegible-next
    atkinson-hyperlegible-mono
    nerd-fonts.jetbrains-mono
  ];
}
