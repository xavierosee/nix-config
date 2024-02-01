{ inputs, pkgs, ... }:

{
  homebrew = {
    enable = true;
    casks = [
      "1password"
      "discord"
      "google-chrome"
      "istat-menu"
      "spotify"
    ];
  };

  users.users.xavierosee = {
    home = "/Users/xavierosee";
    shell = pkgs.fish;
  };
}
