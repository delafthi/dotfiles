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
      trusted-users = if pkgs.hostPlatform.isDarwin then [ "@admin" ] else [ "@wheel" ];
    };
  };
}
