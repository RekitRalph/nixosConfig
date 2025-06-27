{ config, pkgs, ... }: {

   programs.helix = {
      enable = true;
      defaultEditor = true;
      extraPackages = [ 
        pkgs.marksman 
        pkgs.nil
        pkgs.vscode-langservers-extracted
        
      ];
   };

   # point to the helix config file in "/nixos/config/helix" 
  #xdg.configFile."helix/config.toml".source = 
  #config.lib.file.mkOutOfStoreSymlink 
  #"${config.home.homeDirectory}/nixos/modules/home/helix/config.toml";

  #xdg.configFile."helix/languages.toml".source = 
  #config.lib.file.mkOutOfStoreSymlink 
  #"${config.home.homeDirectory}/nixos/modules/home/helix/languages.toml";
      /*
      settings = {
         theme = "onedarker";
        editor = {
          bufferline = "multiple";
        };
        editor.cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      languages.language = [{
        name = "nix";
        auto-format = false;
        formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
      }]; 
    };*/
   


}
