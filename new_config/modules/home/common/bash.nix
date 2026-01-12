{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      # Fixed: removed dead "pp" alias
      ll = "eza -lh --group-directories-first --color=always --icons=always";
      ls = "eza --group-directories-first --color=always --icons=always";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos/new_config";
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

  # Compare script for system generations
  home.packages = [
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
}
