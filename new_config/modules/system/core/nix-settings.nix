{ config, ... }:

let
  cfg = config.myOptions;
in
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = cfg.storage.garbageCollection.automatic;
    dates = cfg.storage.garbageCollection.dates;
    options = cfg.storage.garbageCollection.options;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
