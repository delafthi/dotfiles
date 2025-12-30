{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  targets.darwin.defaults = {
    NSGlobalDomain.NSWindowShouldDragOnGesture = true;
    "com.apple.AppleMultiTouchTrackpad" = {
      TrackpadThreeFingerDrag = true;
    };
  };
}
