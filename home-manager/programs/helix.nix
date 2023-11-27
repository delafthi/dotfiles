{
  home.sessionVariables.EDITOR = "hx";
  programs.helix = {
    enable = true;
    # defaultEditor = true;
    # extraPackages = with pkgs; [
      # clang
      # cmake-language-server
      # docker-langserver
      # lua-language-server
      # marksman
      # nil
      # python-lsp-server
      # svlangserver
      # texlab
      # vhdl-ls
      # yaml-language-server
    # ];
    settings = {
      theme = "onedark";
      editor = {
        bufferline = "multiple";
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        line-number = "relative";
        scrolloff = 8;
        soft-wrap.enable = true;
        statusline = {
          left = [ "mode" "version-control" "diagnostics" ];
          center = [ ];
          right = [ "file-modification-indicator" "file-base-name" "file-type" "position" "total-line-numbers" ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };
      };
    };
  };
}