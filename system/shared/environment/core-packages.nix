{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      uutils-coreutils-noprefix
      curl
      git
      vim
    ];
  };
}
