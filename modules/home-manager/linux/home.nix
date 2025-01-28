{ lib
, config
, pkgs
, ...
}: {
  imports = [
    (import ../home.nix { inherit lib config pkgs; })
    (import ./dconf.nix { inherit lib; })
    (import ./gtk.nix { inherit config pkgs; })
    (import ./services.nix { inherit pkgs; })
    ./xdg.nix
  ];

  home = {
    file.Downloads.source = "${config.home.homeDirectory}/Documents/0-inbox/downloads";
    packages = with pkgs; [
      brave
      noto-fonts
      noto-fonts-emoji
    ];
    shellAliases = {
      open = "xdg-open";
    };
  };

  # Enable home-manager to start the X session (otherwise graphical services are not started automatically)
  xsession.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
