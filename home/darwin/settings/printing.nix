{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  targets.darwin.defaults."com.apple.print.PrintingPrefs"."Quit When Finished" = true;
}
