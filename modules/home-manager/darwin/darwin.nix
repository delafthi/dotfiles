{
  targets.darwin = {
    currentHostDefaults = {
      "com.apple.controlcenter" = {
        BatteryShowPercentage = true;
      };
    };
    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        AppleLanguages = [ "en-US" "de-CH" ];
        AppleLocale = "en_US@rg=chzzzz";
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = true;
        AppleShowAllExtensions = false;
        AppleShowAllFiles = true;
        AppleTemperatureUnit = "Celsius";
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        NSWindowShouldDragOnGesture = true;
      };
      "com.apple.AppleMultiTouchTrackpad" = {
        TrackpadThreeFingerDrag = true;
      };
      "com.apple.AdLib" = {
        allowApplePersonalizedAdvertising = false;
        allowIdentifierForAdvertising = false;
        forceLimitAdTracking = true;
      };
      "com.apple.commerce" = {
        AutoUpdate = true;
      };
      "com.apple.desktopservices" = {
        DSDontDriveNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.dock" = {
        autohide = true;
        mineffect = "scale";
        minimize-to-application = true;
        orientation = "bottom";
        persistent-apps = (map (app: { tile-data = { file-data = { _CFURLString = app; _CFURLStringType = 0; }; }; })
          [
            "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
            "/Applications/WhatsApp.app"
            "/Applications/Proton Mail.app"
            "/Applications/Proton Pass.app"
            "/System/Applications/Music.app"
            "/Applications/Things3.app"
            "/Applications/Bear.app"
            "/Applications/ghostty.app"
          ]);
        show-recents = false;
        showhidden = true;
        tilesize = 60;
      };
      "com.apple.finder" = {
        _FXSortFoldersFirst = true;
        AppleShowAllFiles = true;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        QuitMenuItem = false;
        ShowExternalHardDrivesOnDesktop = false;
        ShowHardDrivesOnDesktop = false;
        ShowMountedServersOnDesktop = false;
        ShowPathBar = true;
        ShowRemovableMediaOnDesktop = false;
        ShowStatusBar = false;
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
        AutoFillCreditCardData = true;
        AutoFillPasswords = true;
        AutoOpenSafeDownloads = false;
        ExcludePrivateWindowWhenRestoringSessionAtLaunch = true;
        IncludeDevelopMenu = true;
        SendDoNotTrackHTTPHeader = true;
      };
      screencapture = {
        location = "~/Library/Mobile Documents/com~apple~CloudDocs/0-inbox/screenshots";
        type = "png";
      };
    };
    keybindings = {
      "^u" = "deleteToBeginningOfLine:";
      "^w" = "deleteWordBackward:";
    };
    search = "Google";
  };
}
