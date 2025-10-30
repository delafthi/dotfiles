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
      experimental-features = [
        "auto-allocate-uids"
        "ca-derivations"
        "dynamic-derivations"
        "flakes"
        "nix-command"
        "pipe-operators"
      ];
      sandbox = true;
      substituters = [ "https://numtide.cachix.org" ];
      trusted-public-keys = [ "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE=" ];
      trusted-users = if pkgs.stdenv.hostPlatform.isDarwin then [ "@admin" ] else [ "@wheel" ];
    };
  };
}
