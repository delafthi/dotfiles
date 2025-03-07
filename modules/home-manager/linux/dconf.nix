{lib}:
with lib.hm.gvariant; {
  dconf = {
    settings = {
      "com/github/stunkymonkey/nautilus-open-any-terminal" = {
        terminal = "ghostty";
      };
      "org/gnome/desktop/input-sources" = {
        sources = [(mkTuple ["xkb" "us+mac"])];
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
        close = ["<Super>q"];
        maximize = ["<Shift><Control><Super>F"];
        minimize = ["<Super>m"];
        move-to-monitor-left = ["<Control><Super>p"];
        move-to-monitor-right = ["<Control><Supern"];
        move-to-workspace-1 = ["<Control><Super>1"];
        move-to-workspace-2 = ["<Control><Super>2"];
        move-to-workspace-3 = ["<Control><Super>3"];
        move-to-workspace-4 = ["<Control><Super>4"];
        move-to-workspace-5 = ["<Control><Super>5"];
        move-to-workspace-left = ["<Control><Super>Left"];
        move-to-workspace-right = ["<Control><Super>Right"];
        show-desktop = ["<Shift><Control><Super>h"];
        switch-applications = ["<Super>Tab"];
        switch-applications-backward = ["<Shift><Super>Tab"];
        switch-group = ["<Super>grave"];
        switch-group-backward = ["<Shift><Super>grave"];
        switch-input-source = ["<Control><Alt>Space"];
        switch-input-source-backward = ["<Control>Space"];
        switch-to-workspace-1 = ["<Control>1"];
        switch-to-workspace-2 = ["<Control>2"];
        switch-to-workspace-3 = ["<Control>3"];
        switch-to-workspace-4 = ["<Control>4"];
        switch-to-workspace-5 = ["<Control>5"];
        switch-to-workspace-last = [];
        switch-to-workspace-left = ["<Control>Left"];
        switch-to-workspace-right = ["<Control>Right"];
        toggle-fullscreen = ["<Control><Super>f"];
      };
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        edge-tiling = true;
        workspaces-only-on-primary = true;
      };
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = ["<Control><Super>h"];
        toggle-tiled-right = ["<Control><Super>l"];
      };
      "org/gnome/settings-daemon-plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
        logout = ["<Shift><Super>q"];
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
        open-application-menu = ["<Shift><Control><Super>a"];
        screenshot = ["<Shift><Super>3"];
        screenshot-window = ["<Shift><Super>4"];
        show-screen-recording-ui = ["<Shift><Super>5"];
        show-screenshot-ui = ["<Control><Shift><Super>3"];
        toggle-application-view = ["<Control>Down"];
        toggle-message-tray = ["<Control><Shift><Super>n"];
        toggle-overview = ["<Control>Up"];
      };
      "org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings" = {
        copy = ["<Super>c" "<Control>c"];
        paste = ["<Super>v" "<Control>v"];
        new-tab = ["<Super>t" "<Control>t"];
        new-window = ["<Super>n"];
        close-tab = ["<Super>w"];
        close-window = ["<Super>q"];
        find = ["<Super>f" "<Control>f"];
      };
    };
  };
}
