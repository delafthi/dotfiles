{
  programs.bash = {
    enable = true;
    historyControl = ["ignoredups" "ignorespace"];
    historyIgnore = ["ls" "exit"];
    shellOptions = [
      "autocd"
      "cdspell"
      "cmdhist"
      "dotglob"
      "histappend"
      "expand_aliases"
      "checkwinsize"
    ];
  };
}
