{ config, pkgs, ... }:

{
  imports = [
    ../shared
  ];

  nix-homebrew = {
    user = "xavier";
    taps = {
      "homebrew/homebrew-core" = {
        url = "github:homebrew/homebrew-core";
        flake = false;
      };
      "homebrew/homebrew-cask" = {
        url = "github:homebrew/homebrew-cask";
        flake = false;
      };
      "homebrew/homebrew-bundle" = {
        url = "github:homebrew/homebrew-bundle";
        flake = false;
      };
    };

    mutableTaps = false;
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    global.autoUpdate = false;

    casks = [
      "1password"
      "discord"
      "google-chrome"
      "slack"
      "spotify"
      "telegram"
      "whatsapp"
    ];
    
  };


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
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
    nonUS.remapTilde = true;
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";
}