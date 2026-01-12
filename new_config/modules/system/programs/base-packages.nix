{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Basic utilities - will expand this later
    wget
    curl
    git
    vim
    neovim
    htop
  ];
}
