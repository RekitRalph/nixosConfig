{pkgs, lib, ...}:

let 
  cursorPkg = pkgs.bibata-cursors;
  cursorName = "Bibata-Original-Ice";
  cursorSize = 20;

  iconName = "Dracula";
  iconPkg = pkgs.dracula-icon-theme;

  themePkg = pkgs.dracula-theme;
  themeName = "Dracula";
  in
{  
  gtk = {
    enable = true; 
    cursorTheme = {
      package = cursorPkg;
      name = cursorName;
      size = cursorSize;
    };


    iconTheme = {
      package = iconPkg;
      name = iconName;
    };
    
      theme = {
      name = themeName;
      package = themePkg; 
      }; 
    
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-button-images = 1;
      gtk-cursor-theme-name = cursorName;
      gtk-cursor-theme-size = cursorSize;
      gtk-decoration-layout = "icon:minimize,maximize,close";
      gtk-enable-animations = 1;
      gtk-font-name = "DejaVu Sans,  10";
      gtk-icon-theme-name = iconName;
      gtk-menu-images = 1;
      gtk-modules = "colorreload-gtk-module";
      gtk-primary-button-warps-slider = 0;
      gtk-toolbar-style = 3;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-cursor-theme-name = cursorName;
      gtk-cursor-theme-size = cursorSize;
      gtk-decoration-layout = "icon:minimize,maximize,close";
      gtk-enable-animations = 1;
      gtk-font-name = "DejaVu Sans,  10";
      gtk-icon-theme-name = iconName;
      gtk-modules = "colorreload-gtk-module";
      gtk-primary-button-warps-slider = 0;
    };
  };
   /* font = lib.mkForce {
      package = pkgs.ibm-plex;
      name = "IBM Plex Sans";
    };*/
    
   /*iconTheme = {
      name = "Colloid-grey-dark";
      package = pkgs.colloid-icon-theme.override {
        colorVariants = ["grey"];
      };
    };*/

  # Force qt to mimic configured gtk theme
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };
}
