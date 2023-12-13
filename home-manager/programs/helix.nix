{ pkgs ? import <nixpkgs> { } }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      buf-language-server
      clang-tools
      cmake-language-server
      dockerfile-language-server-nodejs
      lua-language-server
      marksman
      nil
      (python3.withPackages (ps: with ps; [
        black
        python-lsp-server
        python-lsp-ruff
        python-lsp-black
      ]))
      ruff
      svls
      texlab
      vhdl-ls
      vscode-extensions.llvm-org.lldb-vscode
      yaml-language-server
    ];
    languages = {
      language-server.pylsp = {
        config = {
          pylsp = {
            plugins = {
              black.enabled = true;
              ruff.enabled = true;
            };
          };
        };
      };
    };
    settings = {
      theme = "onedark";
      editor = {
        bufferline = "multiple";
        color-modes = true;
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
          left = [ "mode" "spacer" "version-control" ];
          center = [ "file-name" ];
          right = [ "diagnostics" "file-modification-indicator" "read-only-indicator" "file-type" "separator" "position" "total-line-numbers" ];
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
