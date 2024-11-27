{ config, pkgs, ... }:

{

  # Use "dconf watch /" to see state changes in gnome settings

  dconf.settings = {
    
    "org/gnome/desktop/session" = {
      idle-delay = "uint32 600"; # screen blank after '10' minutes
    };
    
    "/org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "'nothing'"; # automatic suspend 'off'
      power-button-action = "'interactive'"; # power button behavior 'power off'
    };

    "/org/gnome/mutter" = {
      dynamic-workspaces = "true"; # Dynamic Workspaces 'on'
      edge-tiling = "true" # edge tiling 'on'
    };

     "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      focus-mode = "click";
      resize-with-right-button = true;
    };

    # keybindings
    "/org/gnome/desktop/wm/keybindings" = {
      close = ["'<Super>q'"]; # close window
      maximize = [ "<Super>F11" ];
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];   
     };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>t";
        command = "kitty";
        name = "open terminal";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>f";
        command = "thunar";
        name = "Open file browser";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        binding = "<Super>b";
        command = "firefox";
        name = "Open browser";
      }; 

      "org/gnome/shell/extensions/user-theme" = {
        name = "Dracula";
      };

      "/org/gnome/desktop/interface/" = {
        icon-theme = "Dracula";
        gtk-theme = "Dracula";
      };

      "org/gnome/shell/extensions/dash-to-panel" = {
        animate-appicon-hover-animation-extent = {
          RIPPLE = 4;
          PLANK = 4;
          SIMPLE = 1;
        };
        appicon-margin = 8;
        appicon-padding = 4;
        appicon-style = "NORMAL";
        available-monitors = [ 0 ];
        dot-position = "TOP";
        hotkeys-overlay-combo = "TEMPORARILY";
        intellihide = false;
        intellihide-behaviour = "ALL_WINDOWS";
        intellihide-hide-from-windows = true;
        leftbox-padding = -1;
        panel-anchors = ''
          {"0":"MIDDLE"}
        '';
        panel-element-positions = ''
          {"0":[{"element":"showAppsButton","visible":true,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"centerMonitor"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}
        '';
        panel-lengths = ''
          {"0":100}
        '';
        panel-positions = ''
          {"0":"TOP"}
        '';
        panel-sizes = ''
          {"0":32}
        '';
        primary-monitor = 0;
        show-apps-icon-file = "";
        show-apps-icon-side-padding = 7;
        status-icon-padding = -1;
        tray-padding = -1;
        window-preview-title-position = "TOP";
      }; 
  };

}
