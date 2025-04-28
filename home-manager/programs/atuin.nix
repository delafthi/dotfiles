{
  programs.atuin = {
    enable = true;
    daemon.enable = true;
    settings = {
      filter_mode_shell_up_key_binding = "directory";
      invert = true;
      history_filter = [
        "^cd"
      ];
    };
  };
}
