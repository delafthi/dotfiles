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
        "https://cache.flox.dev"
        "https://numtide.cachix.org"
      ];
      trusted-public-keys = [
        "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
      trusted-users = if pkgs.stdenv.hostPlatform.isDarwin then [ "@admin" ] else [ "@wheel" ];
    };
  };
}
