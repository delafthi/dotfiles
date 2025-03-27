{lib, ...}:
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
        maximize = ["<Control><Super>f"];
        minimize = ["<Super>m"];
        show-desktop = ["<Control><Super>d"];
        switch-applications = ["<Super>Tab"];
        switch-applications-backward = ["<Shift><Super>Tab"];
        switch-group = ["<Super>grave"];
        switch-group-backward = ["<Shift><Super>grave"];
        switch-input-source = ["<Control><Alt>Space"];
        switch-input-source-backward = ["<Control>Space"];
        switch-to-workspace-left = ["<Control>Left"];
        switch-to-workspace-right = ["<Control>Right"];
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "close,minimize,maximize:appmenu";
      };
      "org/gnome/mutter" = {
        center-new-windows = true;
        dynamic-workspaces = true;
        edge-tiling = true;
        workspaces-only-on-primary = true;
      };
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = ["<Control><Super>h"];
        toggle-tiled-right = ["<Control><Super>l"];
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
        logout = ["<Shift><Super>q"];
        screensaver = ["<Control><Super>q"];
      };
      "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Control><Super>Return";
        command = "ghostty";
        name = "Ghostty";
      };
      "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Control><Super>b";
        command = "zen";
        name = "Zen";
      };
      "org/gnome/shell" = {
        favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "zen.desktop"
          "proton-mail.desktop"
          "proton-pass.desktop"
          "com.mitchellh.ghostty.desktop"
        ];
      };
      "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        apply-custom-theme = true;
        autohide = true;
        autohide-in-fullscreen = true;
        custom-background-color = true;
        background-color = "#292b35";
        custom-theme-shrink = true;
        dash-max-icon-size = 60;
        hot-keys = false;
        icon-size-fixed = true;
        minimize-shift = false;
        position = "BOTTOM";
        show-mounts = false;
      };
      "org/gnome/shell/extensions/keep-me-awake" = {
        use-bold-icons = true;
      };
      "org/gnome/shell/extensions/search-light" = {
        background-color = mkTuple [0.11765 0.12941 0.1451 1.0];
        border-color = mkTuple [0.4 0.40784 0.41569 1.0];
        border-radius = 1.1;
        border-thickness = 1;
        shortcut-search = ["<Super>Space"];
      };
      "org/gnome/shell/keybindings" = {
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
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };
}
