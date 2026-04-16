{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      border-radius = 8;
      margin = "8";
      padding = "8,12";
      max-icon-size = 48;
      font = "IosevkaAile 14";
      format = "%s\\n%b";
    };
  };
}
