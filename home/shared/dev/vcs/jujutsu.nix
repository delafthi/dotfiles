{ pkgs, ... }:
{
  home.packages = [ pkgs.difftastic ];
  programs.jujutsu = {
    enable = true;
    settings = {
      aliases = {
        a = [
          "file"
          "track"
        ];
        b = [ "bookmark" ];
        c = [ "commit" ];
        clone = [
          "git"
          "clone"
          "--colocate"
        ];
        d = [
          "util"
          "exec"
          "--"
          "sh"
          "-c"
          "jj diff --git --context 5 --no-pager | mods --role commit-message-generator | jj describe --edit --stdin"
        ];
        desc = [ "describe" ];
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
        i = [
          "new"
          "--after"
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
        review = [
          "util"
          "exec"
          "--"
          "sh"
          "-c"
          "${pkgs.code-review}/bin/review $@"
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
        diff-formatter = [
          "difft"
          "--tab-width=2"
          "--display=inline"
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
