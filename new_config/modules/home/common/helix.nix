{ pkgs, lib, hostConfig, ... }:

let
  cfg = hostConfig.myOptions.home;
in
lib.mkIf cfg.enableHelix {

  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      # LSP servers
      nil  # Nix LSP
      rust-analyzer
      nodePackages.typescript-language-server
      nodePackages.bash-language-server
      marksman  # Markdown LSP
      yaml-language-server

      # Formatters
      nixpkgs-fmt
      rustfmt
      nodePackages.prettier
    ];
  };
}
