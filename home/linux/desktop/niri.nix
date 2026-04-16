{
  lib,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  home.packages = with pkgs; [
    brightnessctl
    wl-clipboard-rs
    wlrctl
    xwayland-satellite
  ];
  services.polkit-gnome.enable = true;
  xdg.configFile."niri/config.kdl".text = ''
    input {
      keyboard {
        xkb {
          layout "us"
          variant "mac"
        }
        repeat-delay 300
        repeat-rate 50
      }
      touchpad {
        tap
        natural-scroll
      }
      mouse {
        natural-scroll
      }
      warp-mouse-to-focus mode="center-xy"
    }

    output "DP-1" {
      position x=0 y=0
      focus-at-startup
    }

    output "DP-2" {
      position x=2560 y=120
    }

    layout {
      gaps 8
      center-focused-column "always"
      preset-column-widths {
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
        proportion 0.9
      }
      default-column-width { proportion 0.9; }
      focus-ring {
        width 2
        active-color "#89b4fa"
        inactive-color "#313244"
      }
      border {
        off
      }
    }

    cursor {
      xcursor-size 24
      hide-when-typing
      hide-after-inactive-ms 10000
    }

    prefer-no-csd

    screenshot-path "~/Documents/00-inbox/screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    hotkey-overlay {
      skip-at-startup
    }

    window-rule {
      geometry-corner-radius 8
      clip-to-geometry true
    }

    // File pickers, save/open dialogs, portal windows
    window-rule {
      match app-id=r#"xdg-desktop-portal"#
      match title=r#"(Open|Save|Select|Pick|Choose|Import|Export)"#
      open-floating true
    }

    // Cloud sync and tray utility windows
    window-rule {
      match app-id=r#"(owncloud|nextcloud|com\.owncloud|com\.nextcloud)"#
      open-floating true
    }

    // Network, audio, bluetooth managers
    window-rule {
      match app-id=r#"(nm-connection-editor|nm-applet|pavucontrol|blueman)"#
      open-floating true
    }

    // Auth dialogs, keyring, password prompts
    window-rule {
      match app-id=r#"(polkit|pkexec|org\.gnome\.PolicyKit|gcr-prompter|pinentry)"#
      open-floating true
    }

    gestures {
      hot-corners {
        off
      }
    }

    recent-windows {
      binds {
        Mod+Tab         { next-window; }
        Mod+Shift+Tab   { previous-window; }
        Mod+grave       { next-window     filter="app-id"; }
        Mod+Shift+grave { previous-window filter="app-id"; }
      }
    }

    binds {
      // Applications
      Mod+Ctrl+Return { spawn-sh "wlrctl window focus com.mitchellh.ghostty || ghostty"; }
      Mod+Ctrl+B { spawn-sh "wlrctl window focus zen-beta || zen-beta"; }
      Mod+Space { spawn "fuzzel"; }

      // Window management
      Mod+Q { close-window; }
      Mod+Ctrl+C { toggle-window-floating; }
      Mod+Ctrl+F { maximize-column; }
      Mod+Shift+F { fullscreen-window; }

      // Monitor focus
      Mod+Ctrl+H { focus-monitor-left; }
      Mod+Ctrl+L { focus-monitor-right; }
      Mod+Shift+H { move-column-to-monitor-left; }
      Mod+Shift+L { move-column-to-monitor-right; }

      // Lock screen
      Mod+Ctrl+Q { spawn "swaylock"; }

      // Workspaces
      Mod+Ctrl+J { focus-workspace-down; }
      Mod+Ctrl+K { focus-workspace-up; }
      Mod+Shift+J { move-column-to-workspace-down; }
      Mod+Shift+K { move-column-to-workspace-up; }

      Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
      Mod+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }

      // Quit niri
      Mod+Ctrl+Shift+Q { quit; }

      // Media keys
      XF86AudioRaiseVolume allow-when-locked=true { spawn "swayosd-client" "--output-volume" "raise"; }
      XF86AudioLowerVolume allow-when-locked=true { spawn "swayosd-client" "--output-volume" "lower"; }
      XF86AudioMute allow-when-locked=true { spawn "swayosd-client" "--output-volume" "mute-toggle"; }
      XF86MonBrightnessUp { spawn "swayosd-client" "--brightness" "raise"; }
      XF86MonBrightnessDown { spawn "swayosd-client" "--brightness" "lower"; }
    }
  '';
}
