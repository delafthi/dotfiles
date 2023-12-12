{ lib, ... }:

with lib.hm.gvariant;
{
  dconf = {
    settings = {
      "com/github/stunkymonkey/nautilus-open-any-terminal" = {
        terminal = "alacritty";
      };
      "org/gnome/desktop/input-sources" = {
        sources = [ (mkTuple [ "xkb" "us+mac" ]) ];
        xkb-options = [ ];
      };
      "org/gnome/desktop/peripherals/mouse" = {
        natural-scroll = true;
      };
      "org/gnome/desktop/wm/keybindings" = {
        activate-window-menu = [ ];
        begin-move = [ ];
        begin-resize = [ ];
        close = [ "<Super>d" ];
        cycle-group = [ ];
        cycle-group-backward = [ ];
        cycle-panels = [ ];
        cycle-panels-backward= [ ];
        cycle-windows = [ ];
        cycle-windows-backward = [ ];
        maximize = [ "<Super>Up" ];
        minimize = [ ];
        move-to-monitor-down = [ ];
        move-to-monitor-left = [ "<Shift><Super>p" ];
        move-to-monitor-right = [ "<Shift><Super>n" ];
        move-to-monitor-up= [ ];
        move-to-workspace-1 = [ "<Shift><Super>1" ];
        move-to-workspace-2 = [ "<Shift><Super>2" ];
        move-to-workspace-3 = [ "<Shift><Super>3" ];
        move-to-workspace-4 = [ "<Shift><Super>4" ];
        move-to-workspace-5 = [ "<Shift><Super>5" ];
        move-to-workspace-last = [ ];
        move-to-workspace-left = [ ];
        move-to-workspace-right = [ ];
        panel-run-dialog = [ ];
        switch-applications = [ ];
        switch-applications-backward = [ ];
        switch-group = [ ];
        switch-group-backward = [ ];
        switch-input-source = [ ];
        switch-input-source-backward = [ ];
        switch-panels = [ ];
        switch-panels-backward = [ ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        switch-to-workspace-last = [ ];
        switch-to-workspace-left = [ ];
        switch-to-workspace-right = [ ];
        switch-windows = [ "<Super>j" ];
        switch-windows-backward = [ "<Super>k" ];
        toggle-fullscreen = [ "<Super>m" ];
      };
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        edge-tiling = true;
        workspaces-only-on-primary = true;
      };
      "org/gnome/mutter/keybindings" = {
        switch-monitor = [ "<Shift><Super>d" "XF86Display" ];
      };
      "org/gnome/settings-daemon-plugins/media-keys" = {
        custom-keybindings = [ 
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" 
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" 
        ];
        help = [ ];
        home = [ "<Super>e" ];
        logout = [ "<Shift><Super>q" ];
        magnifier = [ ];
        magnifier-zoom-in = [ ];
        magnifier-zoom-out = [ ];
        screenreader = [ ];
        screensaver = [ "<Super>Escape" ];
        search = [ "<Shift><Super>Return" ];
        www = [ "<Super>b" ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>Return";
        command = "alacritty";
        name = "Alacritty";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>z";
        command = "zotero";
        name = "Zotero";
      };
      "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
      };
      "org/gnome/shell/keybindings" = {
        focus-active-notification = [ ];
        open-application-menu = [ ];
        screenshot = [ ];
        screenshot-window = [ ];
        show-screen-recording-ui = [ ];
        show-screenshot-ui = [ "<Super>s" ];
        switch-to-application-1 = [ ];
        switch-to-application-2 = [ ];
        switch-to-application-3 = [ ];
        switch-to-application-4 = [ ];
        toggle-application-view = [ "<Super>a" ];
        toggle-message-tray = [ ];
        toggle-overview = [ ];
      };
    };
  };
}
