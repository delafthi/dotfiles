{
  lib,
  config,
  pkgs,
  tokyonight,
  ...
}: {
  imports = [
    ./editorconfig.nix
    ./fonts.nix
    (import ./programs/fish.nix {inherit pkgs tokyonight;})
    ./programs/bash.nix
    (import ./programs/bat.nix {inherit tokyonight;})
    ./programs/bins/default.nix
    (import ./programs/clang.nix {inherit pkgs;})
    ./programs/dircolors.nix
    ./programs/direnv.nix
    (import ./programs/eza.nix {inherit config tokyonight;})
    (import ./programs/fzf.nix {inherit lib pkgs tokyonight;})
    (import ./programs/ghostty.nix {inherit pkgs;})
    (import ./programs/git.nix {inherit pkgs;})
    ./programs/git-cliff.nix
    (import ./programs/gtkwave/default.nix {inherit pkgs;})
    (import ./programs/helix.nix {inherit pkgs;})
    (import ./programs/lazygit.nix {inherit tokyonight;})
    (import ./programs/python.nix {inherit pkgs;})
    ./programs/starship.nix
    (import ./programs/tmux/default.nix {inherit pkgs tokyonight;})
    (import ./programs/yazi.nix {inherit lib pkgs tokyonight;})
    ./programs/zoxide.nix
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
      createDeveloperDirectory = lib.hm.dag.entryAfter ["writeBoundary"] ''
        run mkdir -p $VERBOSE_ARG ${config.home.homeDirectory}/Developer
      '';
    };
    username = "delafthi";
    packages = with pkgs; [
      du-dust
      fd
      gnutar
      hexyl
      htop
      just
      p7zip
      pandoc
      procs
      ripgrep
      tealdeer
      texlive.combined.scheme-full
      tokei
      unrar
      unzip
      yubikey-manager
      yubikey-personalization
      zip
    ];
    preferXdgDirectories = true;
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
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
