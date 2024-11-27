{pkgs, config, ...  }:

{
  
  programs.dconf.enable = true;

  enviroment.systemPackages = with pkgs;[
    wpgtk
    pywal
  ];

}
