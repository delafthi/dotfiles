{ lib, pkgs, ... }:
{
  home.shellAliases = {
    ":q" = "exit";
    cp = "cp -i";
    df = "df -h";
    free = "free -m";
    htop = "htop -t";
    mv = "mv -i";
    rm = "rm -i";
  }
  // lib.optionalAttrs pkgs.hostPlatform.isLinux {
    open = "xdg-open";
  };
}
