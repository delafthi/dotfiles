{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    plugins = with pkgs.nushellPlugins; [
      formats
      query
      # units
    ];
    settings = {
      completions = {
        algorithm = "fuzzy";
        external = {
          enable = true;
        };
      };
      history = {
        isolation = false;
        max_size = 100000;
        sync_on_enter = true;
      };
      show_banner = false;
      use_kitty_protocol = true;
    };
    extraConfig = ''
      let fish_completer = {|spans|
        fish --command $"complete '--do-complete=($spans | str join ' ')'"
        | from tsv --flexible --noheaders --no-infer
        | rename value description
        | update value {
          if ($in | path exists) {$'"($in | str replace "\"" "\\\"" )"'} else {$in}
        }
      }
      $env.completions.external.completer = $fish_completer
    '';
  };
}
