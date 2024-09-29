{ pkgs ? import <nixpkgs> { } }: {
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
    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
    syntaxHighlighting = {
      enable = true;
      highlighters = [ "brackets" "pattern" "regexp" ];
    };
  };
}
