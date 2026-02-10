{ config, pkgs, ... }:
{
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # extraConfig.pipewire."92-low-latency" = {
    # "context.properties" = {
    #   "default.clock.rate" = 48000;
    #   "default.clock.quantum" = 32;
    #   "default.clock.min-quantum" = 32;
    #   "default.clock.max-quantum" = 32;
    # };
    #};

    # extraConfig.pipewire."99-switch-low-latency" = {
    #   "context.modules" = [
    #     {
    #       name = "libpipewire-module-loopback";
    #       args = {
    #         "node.description" = "Nintendo Switch Audio";
    #         "capture.props" = {
    #           "node.name" = "switch_loopback_input";
    #           "target.object" = "alsa_input.usb-Generic_USB_Audio-00.HiFi__Line1__source";
    #           "node.latency" = "64/48000";
    #           "audio.channels" = 2;
    #           "node.passive" = true;
    #         };
    #         "playback.props" = {
    #           "node.name" = "switch_loopback_output";
    #           "media.class" = "Stream/Output/Audio"; # Acts like an app playing audio
    #           "node.latency" = "64/48000";
    #           "node.autoconnect" = true; # Force auto-linking
    #           "node.passive" = true;
    #         };
    #       };
    #     }
    #   ];
    # };

  };
}
