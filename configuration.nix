{ config, lib, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    coreutils
    curl
    delta
    gh
    git
    htop
    jq
    neovim
    poetry
    prettyping
    tmux
  ];

  # Lists packages installed by Homebrew
  homebrew = {
    enable = true;
    global.autoUpdate = false;

    casks = [
      "1password"
      "discord"
      "slack"
      "visual-studio-code"
    ];
  };

  users.users.xavierosee.home = "/Users/xavierosee";
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '';

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  # programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Enable TouchID auth for sudo
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    screencapture.location = "~/Pictures/screenshots";
    screensaver.askForPasswordDelay = 10;
  };

  nix.linux-builder.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 3;

  nix.configureBuildUsers = true;
  nixpkgs.config.allowUnfree = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";
}
