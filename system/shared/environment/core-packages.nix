{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      coreutils
      curl
      git
      vim
    ];
  };
}
