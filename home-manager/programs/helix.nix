{ pkgs ? import <nixpkgs> { } }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      clang-tools
      cmake-language-server
      dockerfile-language-server-nodejs
      lua-language-server
      marksman
      nil
      python311Packages.python-lsp-server
      svls
      texlab
      vhdl-ls
      vscode-extensions.llvm-org.lldb-vscode
      yaml-language-server
    ];
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
