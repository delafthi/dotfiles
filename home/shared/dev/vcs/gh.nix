{ pkgs, ... }:
{
  programs = {
    gh = {
      enable = true;
      extensions = [ pkgs.gh-notify ];
      settings = {
        git_protocol = "ssh";
        pager = "bat";
      };
    };
    gh-dash.enable = true;
  };
}
