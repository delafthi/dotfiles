{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      curl
      gavin-bc
      gawk
      git
      gnugrep
      gnused
      gnutar
      procps
      uutils-coreutils-noprefix
      uutils-diffutils
      uutils-findutils
      vim
    ];
  };
}
