{
  home = {
    shellAliases = {
      zj = "zellij";
    };
  };
  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;
      theme = "custom";
      themes.custom = {
        fg = "#abb2bf";
        bg = "#282c34";
        black = "#282c34";
        red = "#e06c75";
        green = "#98c379";
        yellow = "#e5c07b";
        blue = "#61afef";
        magenta = "#c678dd";
        cyan = "#56b6c2";
        white = "#abb2bf";
        orange = "#d19a66";
      };
    };
  };
  xdg.configFile."zellij/layouts/default.kdl".text = ''layout {
    default_tab_template {
      pane size=1 borderless=true {
        plugin location="zellij:tab-bar"
      }
      children
    }
  }'';
}
