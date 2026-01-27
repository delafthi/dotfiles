{ pkgs, ... }:
{
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openconnect
      networkmanager-openvpn
    ];
  };
}
