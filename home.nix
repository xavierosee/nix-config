{ config, lib, pkgs, ... }:

{
  home.stateVersion = "24.05";

  programs.git = {
    enable = true;
    userName = "Xavier Rosee";
    userEmail = "xavier.rosee@gmail.com";
    extraConfig = {
      github.user = "xavierosee";
      init = { defaultBranch = "main"; };
      diff = { external = "${pkgs.difftastic}/bin/difft"; };
    };
  };
}
