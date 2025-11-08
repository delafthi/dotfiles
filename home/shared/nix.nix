{ pkgs, ... }:
{
  nix = {
    gc = {
      automatic = true;
      dates = if pkgs.stdenv.hostPlatform.isDarwin then [ "daily" ] else [ "03:15" ];
    };
  };
}
