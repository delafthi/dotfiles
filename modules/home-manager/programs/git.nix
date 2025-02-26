{ pkgs }: {
  home = {
    shellAliases = {
      cdr = "cd $(git rev-parse --show-toplevel)";
    };
  };
  programs.git = {
    enable = true;
    aliases = {
      br = "branch";
      co = "checkout";
      c = "commit";
      ca = "commit --amend";
      cane = "commit --amend --no-edit";
      cf = "commit --fixup";
      g = "!git log --oneline --all --graph || true";
      last = "log -1 HEAD";
      pf = "push --force-with-lease";
      save = "!git add -A && git commit -m 'chore: WIP'";
      st = "status --short --branch --show-stash -unormal";
      unstage = "reset HEAD --";
      undo = "reset HEAD~1 --mixed";
    };
    difftastic = {
      enable = true;
      display = "inline";
    };
    extraConfig = {
      branch.sort = "committerdate";
      column.ui = "auto";
      commit.verbose = "true";
      core = {
        fsmonitor = true;
        untrackedCache = true;
      };
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };
      feature.experimental = true;
      fetch = {
        all = true;
        prune = true;
        pruneTags = true;
      };
      help.autocorrect = "prompt";
      init.defaultBranch = "main";
      merge = {
        autoStash = true;
        conflictstyle = "zdiff3";
      };
      pull.rebase = true;
      push = {
        autoSetupRemote = true;
        followTags = true;
      };
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      submodole.recurse = true;
      tag.sort = "version:refname";
    };
    ignores = [
      ".cache"
      ".direnv/"
      ".gdb_history"
      ".lnvim.lua"
      ".null-ls*"
      ".mypy_cache/"
      ".python-version"
      ".ropeproject/"
      "~*"
      "compile_commands.json"
      "mnt/"
    ];
    lfs = {
      enable = true;
    };
    signing = {
      key = "F28424F9874E6696";
      signByDefault = true;
    };
    userEmail = "thierry@delafontaine.xyz";
    userName = "Thierry Delafontaine";
  };
}
