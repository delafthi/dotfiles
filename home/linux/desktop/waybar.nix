{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  services.network-manager-applet.enable = true;
  services.pasystray.enable = true;
  services.blueman-applet.enable = true;

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.main = {
      layer = "top";
      position = "top";
      height = 34;
      spacing = 8;
      margin-top = 0;
      margin-left = 0;
      margin-right = 0;

      modules-left = [ "niri/workspaces" ];
      modules-center = [ "niri/window" ];
      modules-right = [
        "tray"
        "clock"
      ];

      "niri/workspaces" = {
        format = "●";
      };

      "niri/window" = {
        max-length = 60;
      };

      tray = {
        spacing = 8;
      };

      clock = {
        format = "{:%a %d %b  %H:%M}";
        tooltip = false;
      };
    };

    style = ''
      * {
        font-family: "IosevkaAile", sans-serif;
        font-size: 16px;
        font-weight: bold;
        min-height: 0;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background-color: @base;
        color: @text;
      }

      #workspaces button {
        padding: 0 4px;
        background: transparent;
        color: @surface1;
        border: none;
        box-shadow: none;
        font-size: 10px;
      }

      #workspaces button.active,
      #workspaces button.focused {
        color: @blue;
      }

      #window {
        color: @subtext1;
      }

      #clock {
        padding: 0 12px;
        color: @text;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }
    '';
  };
}
