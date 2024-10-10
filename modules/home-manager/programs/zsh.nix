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
    initExtra = ''
      zstyle ':completion:*' menu yes select

      # fix issue where ctrl-r is overwritten with the default history search
      function zvm_after_init() {
        zvm_bindkey viins "^R" fzf-history-widget
      }
    '';
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
