{ pkgs, config, libs, ... }:

{

  stylix.enable = true;

  # Color Theme, Gallery: https://tinted-theming.github.io/base16-gallery/
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gigavolt.yaml";
 /* stylix.base16Scheme = {
          # scheme = "base16";
          # name = "Tomorrow Night";
          # author = "Chris Kempson (http://chriskempson.com)";
              base00: "#202126"   base00: "#11121d"   base00: "#1d2021" # ----           
              base01: "#2d303d"   base01: "#212234"   base01: "#383c3e" # ---
              base02: "#5a576e"   base02: "#212234"   base02: "#53585b" # --
              base03: "#a1d2e6"   base03: "#353945"   base03: "#6f7579" # -
              base04: "#cad3ff"   base04: "#4a5057"   base04: "#cdcdcd" # +
              base05: "#e9e7e1"   base05: "#a0a8cd"   base05: "#d5d5d5" # ++
              base06: "#eff0f9"   base06: "#abb2bf"   base06: "#dddddd" # +++
              base07: "#f2fbff"   base07: "#bcc2dc"   base07: "#e5e5e5" # ++++
              base08: "#ff661a"   base08: "#ee6d85"   base08: "#d72638" # red
              base09: "#19f988"   base09: "#f6955b"   base09: "#eb8413" # orange
              base0A: "#ffdc2d"   base0A: "#d7a65f"   base0A: "#f19d1a" # yellow
              base0B: "#f2e6a9"   base0B: "#95c561"   base0B: "#88b92d" # green
              base0C: "#fb6acb"   base0C: "#9fbbf3"   base0C: "#1ba595" # aqua/cyan
              base0D: "#40bfff"   base0D: "#7199ee"   base0D: "#1e8bac" # blue
              base0E: "#ae94f9"   base0E: "#a485dd"   base0E: "#be4264" # purple
              base0F: "#6187ff"   base0F: "#773440"   base0F: "#c85e0d" # brown
             };*/

  # Set wallpaper, must be set to something.
  stylix.image = ./wallpaper.png;

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
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
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
