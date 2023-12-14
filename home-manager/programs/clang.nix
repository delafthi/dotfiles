{ pkgs ? import <nixpkgs> { } }: {
  home.packages = with pkgs; [ 
    clang-tools
    gcc
    gdb
    doxygen
    ];

  home.file.".clang-format".source = ./.clang-format;
}
