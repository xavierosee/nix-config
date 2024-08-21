{ config, lib, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    coreutils
    curl
    delta
    direnv
    gcc
    gh
    git
    htop
    jq
    neovim
    poetry
    prettyping
    ripgrep
    tmux
    vscode
  ];

  # Lists packages installed by Homebrew
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    global.autoUpdate = false;

    casks = [
      "1password"
      "discord"
      "google-chrome"
      "slack"
    ];
  };

  users.users.xavierosee.home = "/Users/xavierosee";
  users.users.xavierosee.shell = pkgs.bash;
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
    NSGlobalDomain.ApplePressAndHoldEnabled = false;
    screencapture.location = "~/Pictures/screenshots";
    screensaver.askForPasswordDelay = 10;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
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
