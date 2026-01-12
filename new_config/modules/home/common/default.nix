{ ... }:

{
  imports = [
    # Always enabled
    ./bash.nix
    ./kitty.nix
    ./vscode.nix
    ./yazi.nix
    ./mime.nix
    ./dotfiles.nix

    # Optional modules (enabled via myOptions.home.*)
    ./omp.nix
    ./stylix.nix
    ./gtk-theme.nix
    ./pywal.nix
    ./helix.nix
  ];
}
