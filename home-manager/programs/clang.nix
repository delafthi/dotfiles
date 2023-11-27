{ pkgs ? import <nixpkgs> { } }: {
  home.packages = with pkgs; [ 
    gcc
    gdb
    doxygen
    ];

  home.file.".clang-format".source = ./.clang-format;
  home.file.".gdbinit".source = ./.gdbinit;
}