{ pkgs, ... }:
{
  programs = {
    gh = {
      enable = true;
      extensions = with pkgs; [
        gh-notify
      ];
      settings = {
        git_protocol = "ssh";
        pager = "bat";
      };
    };
    gh-dash.enable = true;
  };
}
