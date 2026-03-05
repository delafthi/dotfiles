{ pkgs, ... }:
{
  nix = {
    extraOptions = ''
      connect-timeout = 10
      keep-derivations = true
      keep-going = true
      keep-outputs = true
    '';
    gc.automatic = true;
    optimise.automatic = true;
    settings = {
      download-buffer-size = 524288000;
      experimental-features = [
        "auto-allocate-uids"
        "ca-derivations"
        "dynamic-derivations"
        "flakes"
        "nix-command"
        "pipe-operators"
      ];
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = if pkgs.stdenv.hostPlatform.isDarwin then [ "@admin" ] else [ "@wheel" ];
    };
  };
}
