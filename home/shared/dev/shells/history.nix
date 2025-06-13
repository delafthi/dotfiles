{
  programs.atuin = {
    enable = true;
    daemon.enable = true;
    settings = {
      dialect = "uk";
      filter_mode_shell_up_key_binding = "directory";
      history_filter = [
        "_API_KEY="
        "^cd"
        "^exit$"
      ];
      invert = true;
    };
  };
}
