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
    };
    syntaxHighlighting = {
      enable = true;
      highlighters = [ "brackets" "pattern" "regexp" ];
    };
  };
}
