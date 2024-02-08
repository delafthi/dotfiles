{ pkgs ? import <nixpkgs> { } }: {
  home.packages = with pkgs; [
    clang-tools
    doxygen
    gcc
    gdb
    lldb
  ];

  home.file.".clang-format".source = ./.clang-format;
}
