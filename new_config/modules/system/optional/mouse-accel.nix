{ config, inputs, ... }:

let
  cfg = config.myOptions;
  username = cfg.user.username;
in
{
  imports = [ inputs.maccel.nixosModules.default ];

  hardware.maccel = {
    enable = true;
    enableCli = true;
  };

  users.groups.maccel.members = [ username ];
}
