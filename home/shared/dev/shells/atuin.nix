{
  programs.atuin = {
    enable = true;
    daemon.enable = true;
    settings = {
      dialect = "uk";
      filter_mode_shell_up_key_binding = "directory";
      history_filter = [
        "_API_KEY=\w"
        "^cd"
        "^cdp$"
        "^exit"
        "^hx$"
        "^jj$"
        "^jj \w\s"
        "^oc$"
        "^y$"
        "^yd$"
      ];
      invert = true;
    };
  };
}
