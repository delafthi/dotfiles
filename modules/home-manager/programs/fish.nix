{
  pkgs,
  tokyonight,
  ...
}: {
  programs.fish = {
    enable = true;
    functions = {
      __fish_command_not_found_handler = {
        body = "__fish_default_command_not_found_handler $argv[1]";
        onEvent = "fish_command_not_found";
      };

      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
    };
    interactiveShellInit =
      (builtins.readFile "${tokyonight}/extras/fish/tokyonight_night.fish")
      + ''
        # Settings
        set fish_greeting
        set -g fish_key_bindings fish_vi_key_bindings
        set fish_cursor_default block
        set fish_cursor_insert line
        set fish_cursor_replace_one underscore
        set fish_cursor_replace underscore
        set fish_cursor_external line
        set fish_cursor_visual block
        set fish_vi_force_cursor 1

        # Keybindings
        bind -M insert \ck up-or-search
        bind -M insert \cj down-or-search
        bind -M insert \cl accept-autosuggestion
        bind -M insert \cp up-or-search
        bind -M insert \cn complete
        bind -M insert \cs pager-toggle-search
      '';
    plugins = [
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair-fish.src;
      }
      {
        name = "foreign-env";
        src = pkgs.fishPlugins.foreign-env.src;
      }
    ];
  };
}
