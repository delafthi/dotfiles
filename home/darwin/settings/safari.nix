{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  targets.darwin = {
    defaults."com.apple.Safari" = {
      AlwaysRestoreSessionAtLaunch = true;
      AutoFillCreditCardData = true;
      AutoFillPasswords = true;
      AutoOpenSafeDownloads = false;
      ExcludePrivateWindowWhenRestoringSessionAtLaunch = true;
      IncludeDevelopMenu = true;
      SendDoNotTrackHTTPHeader = true;
    };
    search = "Google";
  };
}
