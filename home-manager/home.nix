{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./editorconfig.nix
    ./fonts.nix
    ./theme.nix
    ./programs
    ./services
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs.home-manager.enable = true;

  home = {
    activation = {
      createDeveloperDirectory = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run mkdir -p $VERBOSE_ARG ${config.home.homeDirectory}/Developer
      '';
    };
    username = "delafthi";
    packages = with pkgs; [
      asciinema
      chatgpt-cli
      du-dust
      fd
      gnutar
      hexyl
      htop
      hyperfine
      just
      nerd-fonts.symbols-only
      p7zip
      pandoc
      procs
      ripgrep
      tealdeer
      tokei
      tree
      unrar
      unzip
      vesktop
      watch
      yubikey-manager
      yubikey-personalization
      zotero
      zip
    ];
    preferXdgDirectories = true;
    sessionPath = [ "$HOME/.local/bin" ];
    shellAliases = {
      ":q" = "exit";
      cp = "cp -i";
      df = "df -h";
      free = "free -m";
      htop = "htop -t";
      mv = "mv -i";
      rm = "rm -i";
      sudo = "sudo -E";
    };
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
  };
}
