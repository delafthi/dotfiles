{
  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    autocd = true;
    autosuggestion = {
      enable = true;
    };
    defaultKeymap = "viins";
    history = {
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
    };
    initExtra = "zstyle ':completion:*' menu yes select";
    syntaxHighlighting = {
      enable = true;
      highlighters = [ "brackets" "pattern" "regexp" ];
    };
  };
}
