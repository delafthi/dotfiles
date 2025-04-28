{ pkgs, ... }:
{
  home.packages = with pkgs; [ bat ];
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
