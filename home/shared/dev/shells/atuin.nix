{ config, ... }:
{
  programs.atuin = {
    enable = true;
    daemon.enable = true;
    settings = {
      dialect = "uk";
      filter_mode_shell_up_key_binding = "directory";
      history_filter = [
        # security
        "--api-key[= ]"
        "--password[= ]"
        "--secret[= ]"
        "--token[= ]"
        ".*-u\\s+\\w+:"
        "_API_KEY="
        "_PASSWORD="
        "_SECRET="
        "_TOKEN="
        "^curl.*(-u|--user)"
        # misc
        "^exit$"
      ];
      invert = true;
      key_path = config.sops.secrets.atuin-key.path;
      session_path = config.sops.secrets.atuin-session.path;
    };
  };
}
