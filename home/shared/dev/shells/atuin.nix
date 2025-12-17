{ config, ... }:
let
  gitAliases = builtins.attrNames config.programs.git.settings.alias;
  jjAliases = builtins.attrNames config.programs.jujutsu.settings.aliases;

  gitFilters = map (alias: "^git ${alias}($|\\s)") gitAliases;
  jjFilters = map (alias: "^jj ${alias}($|\\s)") jjAliases;

  securityFilters = [
    ".*--api-key"
    ".*--password"
    ".*--secret"
    ".*--token"
    ".*-u\\s+\\w+:"
    "_API_KEY="
    "_PASSWORD="
    "_SECRET="
    "_TOKEN="
    "^curl.*(-u|--user)"
    "^sops.*--set"
    "^ssh.*-p\\s"
  ];

  navigationFilters = [
    "^cd($|\\s)"
    "^cdp$"
  ];

  lsFilters = [
    "^l($|\\s)"
    "^la($|\\s)"
    "^ll($|\\s)"
    "^lla($|\\s)"
    "^ls($|\\s)"
  ];

  vcsBaseFilters = [
    "^git$"
    "^jj$"
  ];

  boringFilters = [
    "^exit$"
    "^hx$"
    "^oc$"
    "^y$"
    "^yd$"
  ];

  staticFilters =
    securityFilters ++ navigationFilters ++ lsFilters ++ vcsBaseFilters ++ boringFilters;
in
{
  programs.atuin = {
    enable = true;
    daemon.enable = true;
    settings = {
      dialect = "uk";
      filter_mode_shell_up_key_binding = "directory";
      history_filter = staticFilters ++ gitFilters ++ jjFilters;
      invert = true;
      key_path = config.sops.secrets.atuin-key.path;
      session_path = config.sops.secrets.atuin-session.path;
    };
  };
}
