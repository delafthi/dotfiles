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
      substituters = [ "https://cache.flox.dev" ];
      trusted-public-keys = [ "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs=" ];
      trusted-users = if pkgs.stdenv.hostPlatform.isDarwin then [ "@admin" ] else [ "@wheel" ];
    };
  };
}
