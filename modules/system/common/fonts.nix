{config, pkgs, ...}:
{
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    corefonts
    google-fonts
    font-awesome
    dejavu_fonts
    vistafonts
    nerd-font-patcher
    (nerdfonts.override { fonts = [ "JetBrainsMono" "NerdFontsSymbolsOnly" ]; })
  ];
}