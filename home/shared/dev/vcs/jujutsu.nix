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
        ];
        P = [
          "git"
          "push"
          "--all"
        ];
        track-all = [
          "bookmark"
          "track"
          "glob:*@*"
        ];
        tug = [
          "bookmark"
          "move"
          "--from"
          "heads(::@- & bookmarks())"
          "--to"
          "@-"
        ];
      };
      colors."diff token".underline = false;
      git.sign-on-push = true;
      remotes = {
        origin.auto-track-bookmarks = "*";
        upstream.auto-track-bookmarks = "delafthi/* | main | master";
      };
      signing = {
        backend = "gpg";
        behavior = "drop";
        key = "00926686981863CB";
        backends.ssh.allowed-signers = "~/.ssh/allowed_signers";
      };
      snapshot.auto-track = "none()";
      template-aliases."format_timestamp(timestamp)" = "timestamp.ago()";
      templates.git_push_bookmark = ''"delafthi/" ++ change_id.short()'';
      ui = {
        default-command = "log";
        diff-editor = ":builtin";
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
          "--when".repositories = [ "~/Developer/zhaw" ];
          remotes.origin.auto-track-bookmarks = "deaa/* | main | master";
          templates.git_push_bookmark = ''"deaa/" ++ change_id.short()'';
          signing = {
            backend = "ssh";
            key = "~/.ssh/id_deaa";
          };
          user.email = "deaa@zhaw.ch";
        }
      ];
    };
  };
}
