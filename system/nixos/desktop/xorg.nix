{ pkgs, ... }:
{
  console.useXkbConfig = true;
  environment.systemPackages = [ pkgs.xclip ];
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "mac";
    };
  };
}
