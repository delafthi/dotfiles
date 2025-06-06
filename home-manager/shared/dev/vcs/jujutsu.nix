{ pkgs, ... }:
{
  home.packages = [ pkgs.difftastic ];
  programs.jujutsu = {
    enable = true;
    settings = {
      aliases = {
        a = [ "abandon" ];
        add = [
          "file"
          "track"
        ];
        b = [ "bookmark" ];
        c = [ "commit" ];
        d = [ "describe" ];
        e = [ "edit" ];
        f = [
          "git"
          "fetch"
        ];
        F = [
          "git"
          "fetch"
          "--all-remotes"
        ];
        l = [
          "log"
          "-r"
          "::"
        ];
        n = [ "new" ];
        p = [
          "git"
          "push"
          "--allow-new"
        ];
        P = [
          "git"
          "push"
          "--all"
        ];
      };
      signing = {
        backend = "gpg";
        behavior = "own";
        key = "00926686981863CB";
      };
      snapshot.auto-track = "none()";
      template-aliases."format_timestamp(timestamp)" = "timestamp.ago()";
      ui = {
        default-command = "log";
        diff.tool = [
          "difft"
          "--color=always"
          "$left"
          "$right"
        ];
      };
      user = {
        email = "delafthi@pm.me";
        name = "Thierry Delafontaine";
      };
    };
  };
}
