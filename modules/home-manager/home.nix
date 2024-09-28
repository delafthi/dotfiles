{ lib
, config
, pkgs
, ...
}: {
  imports = [
    ./editorconfig.nix
    ./fonts.nix
    (import ./programs/alacritty.nix { inherit pkgs; })
    ./programs/bash.nix
    ./programs/bat.nix
    (import ./programs/clang.nix { inherit pkgs; })
    ./programs/dircolors.nix
    ./programs/direnv.nix
    ./programs/eza.nix
    ./programs/fzf.nix
    (import ./programs/git.nix { inherit pkgs; })
    (import ./programs/gpg.nix { inherit pkgs; })
    (import ./programs/gtkwave.nix { inherit pkgs; })
    (import ./programs/helix.nix { inherit pkgs; })
    (import ./programs/python.nix { inherit pkgs; })
    ./programs/starship.nix
    ./programs/zellij.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "delafthi";
    homeDirectory = "/Users/delafthi";
    packages = with pkgs; [
      du-dust
      fd
      gnutar
      htop
      just
      pandoc
      procs
      ripgrep
      tealdeer
      texlive.combined.scheme-full
      tokei
      unzip
      yazi
      zip
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
}
