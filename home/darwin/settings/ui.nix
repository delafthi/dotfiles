{
  targets.darwin.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
    };
    "com.apple.desktopservices" = {
      DSDontDriveNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
  };
}
