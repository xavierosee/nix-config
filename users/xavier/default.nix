{ config, pkgs, ... }:

{
  users.users.xavier = {
    # isNormalUser = true;
    home = if pkgs.stdenv.isDarwin then "/Users/xavier" else "/home/xavier";
    description = "Xavier Rosée";
    # extraGroups = [ "admin" "everyone" "localaccounts" "staff" ];
    shell = pkgs.bash;
  };
}