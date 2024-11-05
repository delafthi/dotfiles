{ pkgs ? import <nixpkgs> { } }: {

  programs.kitty = {
    enable = true;
    font = {
      package = (pkgs.nerdfonts.override { fonts = [ "IosevkaTermSlab" ]; });
      name = "IosevkaTermSlab Nerd Font Mono";
      size = 14;
    };
    keybindings = {
      "cmd+c" = "copy_to_clipboard";
      "cmd+d" = "scroll_page_down";
      "cmd+f" = "show_scrollback";
      "cmd+g>e" = "scroll_end";
      "cmd+g>n" = "scroll_to_prompt +1";
      "cmd+g>p" = "scroll_to_prompt -1";
      "cmd+g>s" = "scroll_home";
      "cmd+h" = "hide_macos_app";
      "cmd+m" = "minimize_macos_window";
      "cmd+n" = "new_os_window";
      "cmd+q" = "quit";
      "cmd+s" = "paste_from_selection";
      "cmd+u" = "scroll_page_up";
      "cmd+v" = "paste_from_clipboard";
      "cmd+0" = "change_font_size all 0";
      "cmd+minus" = "change_font_size all -2.0";
      "cmd+plus" = "change_font_size all +2.0";
      "ctrl+cmd+f" = "toggle_fullscreen";
      "ctrl+cmd+u" = "unicode_input";
      "ctrl+cmd+," = "load_config_file";
      "opt+cmd+h" = "hide_maos_other_apps";
      "opt+cmd+s" = "toggle_macos_secure_keyboard_entry";
      "opt+cmd+," = "debug_config";
      "shift+cmd+w" = "close_os_window";
    };
    settings = {
      clear_all_shortcuts = "yes";
      disable_ligatures = "cursor";
      macos_titlebar_color = "#1a1b26";
      macos_quit_when_last_window_closed = "yes";
      scrollback_lines = 10000;
      update_check_interval = 0;
      window_padding_width = 8;
    };
    themeFile = "tokyo_night_night";
  };
}
