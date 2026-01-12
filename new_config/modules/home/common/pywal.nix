{ pkgs, lib, hostConfig, ... }:

let
  cfg = hostConfig.myOptions.home;
in
lib.mkIf cfg.enablePywal {

  home.packages = with pkgs; [
    wpgtk
    pywal
  ];
}
