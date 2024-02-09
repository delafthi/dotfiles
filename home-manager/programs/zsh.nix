{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableVteIntegration = true;
    autocd = true;
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
