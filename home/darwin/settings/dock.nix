{ pkgs, ... }:
{
  targets.darwin.defaults."com.apple.dock" = {
    autohide = true;
    mineffect = "scale";
    minimize-to-application = true;
    orientation = "bottom";
    persistent-apps =
      map
        (app: {
          tile-data.file-data = {
            _CFURLString = "file://${app}/";
            _CFURLStringType = 15;
          };
        })
        [
          "/Applications/Zen.app"
          "/Applications/Proton Mail.app"
          "/Applications/Proton Pass.app"
          "/System/Applications/Music.app"
          "/Applications/Things3.app"
          "/Applications/Obsidian.app"
          "${pkgs.ghostty-bin}/Applications/Ghostty.app"
        ];
    show-recents = false;
    showhidden = true;
    tilesize = 60;
  };
}
