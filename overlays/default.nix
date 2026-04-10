{
  additions =
    final: _:
    (import ../pkgs { pkgs = final; })
    // {
      claude-codePlugins = import ../pkgs/claude-code-plugins { pkgs = final; };
    };
  modifications = import ./modifications;
}
