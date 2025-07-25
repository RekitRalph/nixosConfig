{config, pkgs, ...}:
{
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    corefonts
    google-fonts
    font-awesome
    # dejavu_fonts
    vistafonts
    nerd-font-patcher
    atkinson-hyperlegible-next
    atkinson-hyperlegible-mono
    nerd-fonts.jetbrains-mono
    # nerd-fonts.nerdfontssymbolsonly
    # (nerdfonts.override { fonts = [ "JetBrainsMono" "NerdFontsSymbolsOnly" ]; })
  ];
}
