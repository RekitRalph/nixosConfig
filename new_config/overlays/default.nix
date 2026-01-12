{ ... }:

{
  # Package overlays
  nixpkgs.overlays = [
    # Waybar with experimental features for Hyprland workspaces
    (final: prev: {
      waybar = prev.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = (oldAttrs.mesonFlags or []) ++ [ "-Dexperimental=true" ];
      });
    })
  ];
}
