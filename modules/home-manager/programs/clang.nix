{ pkgs }: {
  home.packages = with pkgs; [
    clang-tools
    doxygen
    gcc
    lldb
  ];

  home.file.".clang-format".source = ./.clang-format;
}
