{ pkgs, ... }:
{
  nix = {
    gc.automatic = true;
    optimise.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      sandbox = true;
      trusted-users = if pkgs.hostPlatform.isDarwin then [ "@admin" ] else [ "@wheel" ];
    };
  };
}
