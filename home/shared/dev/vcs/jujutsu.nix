_: {
  programs.jujutsu = {
    enable = true;
    settings = {
      aliases = {
        a = [
          "file"
          "track"
        ];
        add = [
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
      };
      colors."diff token".underline = false;
      merge-tools.delta.diff-expected-exit-codes = [
        0
        1
      ];
      signing = {
        backend = "gpg";
        behavior = "own";
        key = "00926686981863CB";
      };
      snapshot.auto-track = "none()";
      template-aliases."format_timestamp(timestamp)" = "timestamp.ago()";
      ui = {
        default-command = "log";
        diff-formatter = ":git";
      };
      user = {
        email = "delafthi@pm.me";
        name = "Thierry Delafontaine";
      };
      "--scope" = [
        {
          "--when".commands = [ "status" ];
          ui.paginate = "never";
        }
        {
          "--when".commands = [
            "diff"
            "show"
          ];
          ui.pager = "delta";
        }
      ];
    };
  };
}
