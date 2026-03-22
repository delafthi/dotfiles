{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    functions.ssh = {
      wraps = "ssh";
      description = "Open tv ssh-hosts picker when called without arguments";
      body = ''
        if test (count $argv) -eq 0
          tv ssh-hosts
        else
          command ssh $argv
        end
      '';
    };
    plugins = [
      {
        name = "autopair";
        inherit (pkgs.fishPlugins.autopair-fish) src;
      }
      {
        name = "foreign-env";
        inherit (pkgs.fishPlugins.foreign-env) src;
      }
    ];
  };
}
