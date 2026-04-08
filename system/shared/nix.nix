{ pkgs, ... }:
{
  nix = {
    package = pkgs.lixPackageSets.stable.lix;
    extraOptions = ''
      connect-timeout = 10
      keep-derivations = true
      keep-going = true
      keep-outputs = true
    '';
    gc.automatic = true;
    optimise.automatic = true;
    settings = {
      experimental-features = [
        "auto-allocate-uids"
        "flakes"
        "nix-command"
      ];
      trusted-users = if pkgs.stdenv.hostPlatform.isDarwin then [ "@admin" ] else [ "@wheel" ];
    };
  };
}
