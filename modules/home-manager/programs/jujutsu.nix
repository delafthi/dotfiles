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
        b = ["bookmark"];
        n = ["new"];
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
