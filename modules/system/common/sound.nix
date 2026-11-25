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
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 128;
        "default.clock.min-quantum" = 64;
        "default.clock.max-quantum" = 1024;
      };
    };

    # Fosi K7 (XMOS 20b1:000b) fails to re-open after node suspend
    # (usb_set_interface -32 / clock source invalid), so never suspend it.
    wireplumber.extraConfig."51-fosi-k7-no-suspend" = {
      "monitor.alsa.rules" = [
        {
          matches = [
            { "node.name" = "~alsa_output.usb-Fosi_Audio_Fosi_Audio_K7.*"; }
            { "node.name" = "~alsa_input.usb-Fosi_Audio_Fosi_Audio_K7.*"; }
          ];
          actions.update-props = {
            "session.suspend-timeout-seconds" = 0;
            "node.pause-on-idle" = false;
          };
        }
      ];
    };

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
