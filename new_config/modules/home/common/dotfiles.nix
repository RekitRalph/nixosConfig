{ config, ... }:

let
  # Point to existing dotfiles in old config
  dotfiles = "${config.home.homeDirectory}/nixos/modules/home/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  # Standard .config/directory mappings
  configs = {
    hypr = "hypr";
    helix = "helix";
    waybar = "waybar";
    yazi = "yazi";
    niri = "niri";
    fuzzel = "fuzzel";
  };
in
{
  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;
}
