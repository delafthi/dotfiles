{
  config,
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.sops ];
  sops = {
    defaultSopsFile = ../../../secrets.yaml;
    gnupg.home = "${config.home.homeDirectory}/.gnupg";
    secrets = {
      context7-api-key = { };
      openrouter-api-key = { };
    };
  };
}
