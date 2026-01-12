{ pkgs, lib, hostConfig, ... }:

let
  cfg = hostConfig.myOptions.home;
in
lib.mkIf cfg.enableStylix {

  stylix.enable = true;

  # Color Theme, Gallery: https://tinted-theming.github.io/base16-gallery/
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gigavolt.yaml";

  # Set wallpaper (must point to an existing file if stylix is enabled)
  # You'll need to create this or change to your own wallpaper
  # stylix.image = ./wallpaper.png;

  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Ice";
    size = 24;
  };

  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

  stylix.fonts.sizes = {
    applications = 10;
    terminal = 12;
    desktop = 10;
    popups = 10;
  };
}
