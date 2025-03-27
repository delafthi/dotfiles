{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      difftastic
      lazyjj
    ];
    shellAliases = {
      j = "lazyjj";
    };
  };
  programs.jujutsu = {
    enable = true;
    settings = {
      aliases = {
        a = ["abandon"];
        b = ["bookmark"];
        c = ["commit"];
        d = ["describe"];
        e = ["edit"];
        f = ["git" "fetch"];
        F = ["git" "fetch" "--all-remotes"];
        n = ["new"];
        p = ["git" "push"];
        P = ["git" "push" "--all"];
      };
      signing = {
        behavior = "own";
        backend = "gpg";
        key = "F28424F9874E6696";
      };
      template-aliases = {
        "format_timestamp(timestamp)" = "timestamp.ago()";
      };
      ui = {
        default-command = "log";
        diff.tool = ["difft" "--color=always" "$left" "$right"];
      };
      user = {
        name = "Thierry Delafontaine";
        email = "thierry@delafontaine.xyz";
      };
    };
  };
}
