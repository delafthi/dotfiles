{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 32;
      spacing = 8;
      modules-left = [
        "ext/workspaces"
        "dwl/window"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "tray"
        "pulseaudio"
        "bluetooth"
        "network"
        "battery"
      ];
      "ext/workspaces" = {
        format = "{icon}";
        ignore-hidden = true;
        on-click = "activate";
        on-click-right = "deactive";
        sort-by-id = true;
        format-icons = {
          active = "●";
          default = "○";
        };
      };
      "dwl/window" = {
        format = "{title}";
      };
      clock = {
        format = "{:%a %b %d  %H:%M}";
        tooltip-format = "{:%Y-%m-%d %A}";
      };
      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 muted";
        format-icons.default = [
          "󰕿"
          "󰖀"
          "󰕾"
        ];
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
      network = {
        format-wifi = "󰤨 {signalStrength}%";
        format-ethernet = "󰈀";
        format-disconnected = "󰤭";
        tooltip-format = "{ifname}: {ipaddr}";
      };
      bluetooth = {
        format = "󰂯";
        format-connected = "󰂱 {num_connections}";
        format-disabled = "󰂲";
        on-click = "blueman-manager";
      };
      battery = {
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-icons = [
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
        states = {
          warning = 20;
          critical = 10;
        };
      };
      tray = {
        spacing = 10;
      };
    };
  };
  style = ''
    * {
      font-family: 'IosevkaTermSlab Nerd Font Mono', 'Noto Sans Mono';
      font-size: 14px;
    }
  '';
}
