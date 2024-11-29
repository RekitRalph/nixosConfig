{ config, pkgs, ... }:

{
  home.username = "evan";
  home.homeDirectory = "/home/evan";

  # if home manage fails because of config file run "journalctl -e --unit home-manager-evan.service"
 
  imports = [
    ./omp.nix
    ./kitty.nix
    # ./themes.nix
    # ./dconf.nix
     ./helix
    # ./gtk.nix
  ];

  # stylix.targets.helix.enable = false;  
  
  home.packages = with pkgs; [
    # archives
  ];

  gtk.cursorTheme = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Ice";
    size = 24;
  };
  
  # point to the hyprland config file in "/nixos/config/helix"  
  xdg.configFile."hypr".source = 
  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/modules/home/dotfiles/hypr";

  # waybar config file
  xdg.configFile."waybar".source =
  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/modules/home/dotfiles/waybar";

  # yazi config file
  xdg.configFile."yazi".source =
  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/modules/home/dotfiles/yazi";

  
  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/terminal" = "kitty.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/terminal" = "kitty.desktop";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };

     # VS Codium
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };



  programs.bash = {
    enable = true;
    shellAliases = {
      pp = "echo hello";
      ll = "eza -lh --group-directories-first --color=always --icons=always ";
      ls = "eza --group-directories-first --color=always --icons=always"; 
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos";
      fe = "hx \"$(fzf)\"";
    };
  };
    

  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

}
