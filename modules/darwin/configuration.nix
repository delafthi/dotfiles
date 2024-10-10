{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./homebrew.nix
  ];
  environment = {
    darwinConfig = "$HOME/.nix-config/modules/darwin/configuration.nix";
    loginShell = pkgs.zsh;
    systemPackages = [ pkgs.coreutils ];
  };
  nix = {
    gc.automatic = true;
    optimise.automatic = true;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
  programs = {
    bash = {
      enable = true;
      completion.enable = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    zsh = {
      enable = true;
    };
  };
  security.pam.enableSudoTouchIdAuth = true;
  services.nix-daemon.enable = true;
  system = {
    activationScripts.extraActivation.text = ''
      softwareupdate --install-rosetta --agree-to-license
    '';
    defaults = {
      CustomSystemPreferences = {
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
          allowIdentifierForAdvertising = false;
          forceLimitAdTracking = true;
        };
        "com.apple.desktopservices" = {
          DSDontWriteUSBStores = true;
          DSDontWriteNetworkStores = true;
        };
        "com.apple.finder" = {
          _FXSortFoldersFirst = true;
          ShowHardDrivesOnDesktop = false;
          ShowRemovableMediaOnDesktop = false;
          ShowExternalHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = false;
        };
        "com.apple.Safari" = {
          AutoOpenSafeDownloads = false;
          SendDoNotTrackHTTPHeader = true;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
        };
      };
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        AppleShowAllFiles = true;
      };
      dock = {
        autohide = true;
        mineffect = "scale";
        minimize-to-application = true;
        orientation = "bottom";
        persistent-apps = [
          "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
          "/Applications/WhatsApp.app"
          "/Applications/Proton Mail.app"
          "/Applications/Proton Pass.app"
          "/System/Applications/Music.app"
          "/Applications/Things3.app"
          "/Applications/Bear.app"
          "/Applications/kitty.app"
          "/Applications/Zed.app"
        ];
        show-recents = false;
        showhidden = true;
      };
      finder = {
        AppleShowAllFiles = true;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = true;
        FXPreferredViewStyle = "Nlsv";
        ShowPathbar = true;
      };
      screencapture = {
        location = "$HOME/Library/Mobile Documents/com~apple~CloudDocs/0-inbox/screenshots";
        type = "png";
      };
      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 0;
      };
      trackpad = {
        TrackpadThreeFingerDrag = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    stateVersion = 4;
  };
  users.users = {
    delafthi = {
      description = "Thierry Delafontaine";
      home = "/Users/delafthi";
    };
  };
}
