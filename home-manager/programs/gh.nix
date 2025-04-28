{ pkgs, ... }:
{
  home = {
    file.".local/bin/gh-wrapped" = {
      text = ''
        JJ_ROOT=$(jj root --ignore-working-copy); \
        if [ $? -eq 0 ]; then \
          GIT_DIR=$JJ_ROOT/.jj/repo/store/git gh $@; \
        else \
          gh $@; \
        fi
      '';
      executable = true;
    };
    packages = with pkgs; [ bat ];
    shellAliases = {
      gh = "gh-wrapped";
    };
  };
  programs = {
    gh = {
      enable = true;
      gitCredentialHelper.hosts = [
        "https://gist.github.com"
        "https://github.com"
        "https://github.zhaw.ch"
      ];
      settings = {
        git_protocol = "ssh";
        pager = "bat";
      };
    };
    gh-dash.enable = true;
  };
}
