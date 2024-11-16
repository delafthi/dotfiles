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
    darwinConfig = "$HOME/repos/nix-config/modules/darwin/configuration.nix";
    shellAliases = {
      bash = "${pkgs.bashInteractive}/bin/bash";
    };
    shells = with pkgs; [ bashInteractive fish ];
    systemPackages = [ pkgs.coreutils ];
  };
  nix = {
    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
    gc.automatic = true;
    linux-builder.enable = true;
    optimise.automatic = true;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "@admin" ];
    };
  };
  programs = {
    bash = {
      enable = true;
      completion.enable = true;
    };
    fish = {
      enable = true;
      useBabelfish = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    zsh.enable = true;
  };
  security.pam.enableSudoTouchIdAuth = true;
  services.nix-daemon.enable = true;
  system = {
    activationScripts = {
      extraActivation.text = ''
        softwareupdate --install-rosetta --agree-to-license
      '';
      postUserActivation.text = ''
        /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      '';
    };
    defaults = {
      CustomUserPreferences = {
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
        "com.apple.ImageCapture" = {
          disableHotPlug = true;
        };
        "com.apple.mail" = {
          DisableInlineAttachmentViewing = true;
        };
        "com.apple.print.PrintingPrefs" = {
          "Quit When Finished" = true;
        };
        "com.apple.Safari" = {
          AlwaysRestoreSessionAtLaunch = true;
          AutoFillCreditCardData = false;
          AutoFillFromAddressBook = false;
          AutoFillMiscellaneousForms = false;
          AutoFillPasswords = false;
          AutoOpenSafeDownloads = false;
          ExcludePrivateWindowWhenRestoringSessionAtLaunch = true;
          IncludeInternalDebugMenu = true;
          IncludeDevelopMenu = true;
          SendDoNotTrackHTTPHeader = true;
          WebKitDeveloperExtrasEnabledPreferenceKey = true;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
        };
      };
      CustomSystemPreferences = {
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
          allowIdentifierForAdvertising = false;
          forceLimitAdTracking = true;
        };
        "com.apple.commerce" = {
          AutoUpdate = true;
        };
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
        ];
        show-recents = false;
        showhidden = true;
        tilesize = 60;
      };
      finder = {
        AppleShowAllFiles = true;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        ShowPathbar = true;
      };
      LaunchServices = {
        LSQuarantine = true;
      };
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        AppleShowAllFiles = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
      };
      SoftwareUpdate = {
        AutomaticallyInstallMacOSUpdates = true;
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
      shell = pkgs.fish;
    };
  };
}
