{ pkgs, ... }:
{
  programs = {
    gh = {
      enable = true;
      ];
      settings = {
        git_protocol = "ssh";
        pager = "bat";
      };
    };
    gh-dash.enable = true;
  };
}
