{lib}:
with lib.hm.gvariant; {
  dconf = {
    settings = {
      "com/github/stunkymonkey/nautilus-open-any-terminal" = {
        terminal = "ghostty";
      };
      "org/gnome/desktop/input-sources" = {
        sources = [(mkTuple ["xkb" "ch+mac"])];
        xkb-options = [];
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/desktop/peripherals/mouse" = {
        natural-scroll = true;
      };
      "org/gnome/desktop/sound" = {
        event-sounds = false;
      };
      "org/gnome/desktop/wm/keybindings" = {
        activate-window-menu = [];
        begin-move = [];
        begin-resize = [];
        close = ["<Super>q"];
        cycle-group = [];
        cycle-group-backward = [];
        cycle-panels = [];
        cycle-panels-backward = [];
        cycle-windows = [];
        cycle-windows-backward = [];
        maximize = [];
        minimize = ["<Super>m"];
        move-to-monitor-down = [];
        move-to-monitor-left = ["<Control><Super>p"];
        move-to-monitor-right = ["><Control><Supern"];
        move-to-monitor-up = [];
        move-to-workspace-1 = ["<Control><Super>1"];
        move-to-workspace-2 = ["<Control><Super>2"];
        move-to-workspace-3 = ["<Control><Super>3"];
        move-to-workspace-4 = ["<Control><Super>4"];
        move-to-workspace-5 = ["<Control><Super>5"];
        move-to-workspace-last = [];
        move-to-workspace-left = ["<Control><Super>Left"];
        move-to-workspace-right = ["<Control><Super>Right"];
        panel-run-dialog = [];
        switch-applications = ["<Super>Tab"];
        switch-applications-backward = ["<Super><Shift>Tab"];
        switch-group = [];
        switch-group-backward = [];
        switch-input-source = ["<Control><Alt>Space"];
        switch-input-source-backward = ["<Control>Space"];
        switch-panels = [];
        switch-panels-backward = [];
        switch-to-workspace-1 = ["<Control>1"];
        switch-to-workspace-2 = ["<Control>2"];
        switch-to-workspace-3 = ["<Control>3"];
        switch-to-workspace-4 = ["<Control>4"];
        switch-to-workspace-5 = ["<Control>5"];
        switch-to-workspace-last = [];
        switch-to-workspace-left = ["<Control>Left"];
        switch-to-workspace-right = ["<Control>Right"];
        switch-windows = ["<Control><Super>j"];
        switch-windows-backward = ["<Control><Superk"];
        toggle-fullscreen = ["<Control><Super>f"];
      };
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        edge-tiling = true;
        workspaces-only-on-primary = true;
      };
      "org/gnome/settings-daemon-plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
        help = [];
        home = ["<Super>e"];
        logout = ["<Shift><Super>q"];
        magnifier = [];
        magnifier-zoom-in = [];
        magnifier-zoom-out = [];
        screenreader = [];
        screensaver = ["<Control><Super>Escape"];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Control><Super>Return";
        command = "ghostty";
        name = "Ghostty";
      };
      "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
      };
      "org/gnome/shell/keybindings" = {
        focus-active-notification = [];
        open-application-menu = [];
        screenshot = ["<Shift><Super>3"];
        screenshot-window = ["<Shift><Super>4"];
        show-screen-recording-ui = [];
        show-screenshot-ui = ["<Control><Shift><Super>3"];
        switch-to-application-1 = [];
        switch-to-application-2 = [];
        switch-to-application-3 = [];
        switch-to-application-4 = [];
        toggle-application-view = ["<Control>Down"];
        toggle-message-tray = [];
        toggle-overview = ["<Control>Up"];
      };
    };
  };
}
