{
  description = "Daybreak - Custom launcher for Guild Wars";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        version = "0.9.10.9";

        # Runtime libs required by Photino (GTK3 + WebKitGTK) and .NET
        runtimeLibs = with pkgs; [
          gtk3
          webkitgtk_4_1
          glib
          cairo
          pango
          gdk-pixbuf
          atk
          libsoup_3
          openssl
          zlib
          icu
        ];

        daybreak = pkgs.stdenv.mkDerivation {
          pname = "daybreak";
          inherit version;

          # Pre-built self-contained Linux release — includes the .NET runtime
          src = pkgs.fetchzip {
            url = "https://github.com/gwdevhub/Daybreak/releases/download/v${version}/daybreakv${version}-linux.zip";
            hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
            stripRoot = false;
          };

          nativeBuildInputs = [ pkgs.makeWrapper ];

          installPhase = ''
            mkdir -p $out/lib/daybreak $out/bin
            cp -r . $out/lib/daybreak/
            chmod +x $out/lib/daybreak/Daybreak.Linux

            # Force X11 backend — Photino/WebKitGTK has Wayland issues
            makeWrapper $out/lib/daybreak/Daybreak.Linux $out/bin/daybreak \
              --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath runtimeLibs} \
              --set GDK_BACKEND x11 \
              --set DOTNET_SYSTEM_GLOBALIZATION_INVARIANT false \
              --set DOTNET_CLI_TELEMETRY_OPTOUT 1
          '';

          meta = with pkgs.lib; {
            description = "Custom launcher for Guild Wars";
            homepage    = "https://github.com/gwdevhub/Daybreak";
            license     = licenses.mit;
            mainProgram = "daybreak";
            platforms   = [ "x86_64-linux" ];
          };
        };

      in {
        packages.default = daybreak;
        packages.daybreak = daybreak;

        apps.default = flake-utils.lib.mkApp {
          drv = daybreak;
          name = "daybreak";
        };
      }
    );
}
