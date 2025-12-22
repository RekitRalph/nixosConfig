{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos/modules/home/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  # Standard .config/directory
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

  home.username = "evan";
  home.homeDirectory = "/home/evan";

  # if home manage fails because of config file run "journalctl -e --unit home-manager-evan.service"

  imports = [
    #./omp.nix
    ./kitty.nix
    # ./themes.nix
    # ./dconf.nix
    # ./helix
    # ./gtk.nix
  ];

  # stylix.targets.helix.enable = false;  


  gtk.cursorTheme = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Ice";
    size = 24;
  };

  programs.hyprpanel = {
    enable = true;
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;
  # point to the hyprland config file in "/nixos/config/helix"  
  # xdg.configFile."hypr".source = 
  # config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/modules/home/dotfiles/hypr";


  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/terminal" = "kitty.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/terminal" = "kitty.desktop";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };

  # VS Codium
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };

  programs.yazi.enable = true;

  home.packages = [
    # compares generations to see changes in rebuild.
    (pkgs.writeShellScriptBin "compare" ''
      gens=($(${pkgs.nix}/bin/nix-env --list-generations --profile /nix/var/nix/profiles/system | awk '{print $1}' | sort -n | tail -2))
      if [ "''${#gens[@]}" -lt 2 ]; then
        echo "Not enough generations found!"
        exit 1
      fi

      link1="/nix/var/nix/profiles/system-''${gens[0]}-link"
      link2="/nix/var/nix/profiles/system-''${gens[1]}-link"

      if [ ! -e "$link1" ] || [ ! -e "$link2" ]; then
        echo "One or both system generation links do not exist."
        exit 1
      fi

      ${pkgs.nvd}/bin/nvd diff "$link1" "$link2"
    '')
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      pp = "echo hello";
      ll = "eza -lh --group-directories-first --color=always --icons=always ";
      ls = "eza --group-directories-first --color=always --icons=always";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos";
      fe = "hx \"$(fzf)\"";
    };
    initExtra = ''
      unzipto() {
          unzip "$1" -d "''${1%.zip}"
      }

      download() {
          for file in "$@"/*.acsm; do
              echo "Processing: $file"
              acsmdownloader "$file"
          done
      }
    '';
  };


  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

}
