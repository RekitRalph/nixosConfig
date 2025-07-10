{ inputs, lib, ... }:

{
  # imports = [ inputs.nixos-cosmic.nixosModules.default ];

  # # TODO at the moment COSMIC cannot be used alongside Gnome
  # # https://github.com/lilyinstarlight/nixos-cosmic/issues/17
  # specialisation = {
  #   cosmic.configuration = {
  #     services.xserver.displayManager.gdm.enable = lib.mkForce false;
  #     services.xserver.desktopManager.gnome.enable = lib.mkForce false;

  #     services.desktopManager.cosmic.enable = true;
  #     services.displayManager.cosmic-greeter.enable = true;
  #   };
  # };


  # Enable the COSMIC login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;

  
  services.displayManager.autoLogin = {
    enable = true;
    # Replace `yourUserName` with the actual username of user who should be automatically logged in
    user = "evan";
  };


}