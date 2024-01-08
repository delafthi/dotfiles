{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    (import ./dconf.nix { inherit lib; })
    ./editorconfig.nix
    ./fonts.nix
    (import ./gtk.nix { inherit pkgs; })
    ./programs/alacritty.nix
    ./programs/bash.nix
    ./programs/bat.nix
    (import ./programs/clang.nix { inherit pkgs; })
    ./programs/dircolors.nix
    ./programs/direnv.nix
    ./programs/emacs.nix
    ./programs/eza.nix
    ./programs/firefox.nix
    ./programs/fzf.nix
    (import ./programs/git.nix { inherit pkgs; })
    ./programs/gpg.nix
    (import ./programs/gtkwave.nix { inherit pkgs; })
    (import ./programs/helix.nix { inherit pkgs; })
    (import ./programs/python.nix { inherit pkgs; })
    ./programs/starship.nix
    (import ./programs/tmux.nix { inherit pkgs; })
    ./programs/zathura.nix
    ./programs/zoxide.nix
    ./services.nix
    (import ./xdg.nix { inherit config; })
  ];

  nixpkgs = {
    overlays = [
    ];
   config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs.home-manager.enable = true;

  home = {
    username = "delafthi";
    homeDirectory = "/home/delafthi";
    packages = with pkgs; [
      du-dust
      fd
      gnutar
      htop
      pandoc
      ripgrep
      procs
      tealdeer
      tokei
      wally-cli
      zip
      zotero
    ];
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      ":q" = "exit";
      cp = "cp -i";
      df = "df -h";
      free = "free -m";
      htop = "htop -t";
      mv = "mv -i";
      open = "xdg-open";
      rm = "rm -i";
      sudo = "sudo -E";
    };
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
  };

  # Enable home-manager to start the X session (otherwise graphical services are not started automatically)
  xsession.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
