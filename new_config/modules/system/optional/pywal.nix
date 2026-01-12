{ config, pkgs, lib, ... }:

let
  cfg = config.myOptions.home;
in
lib.mkIf cfg.enablePywal {

  programs.dconf.enable = true;

  # FIXED: Was "enviroment" (typo) in old config
  environment.systemPackages = with pkgs; [
    wpgtk
    pywal
  ];
}
