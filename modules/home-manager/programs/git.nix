{ pkgs ? import <nixpkgs> { } }: {
  home = {
    shellAliases = {
      lg = "lazygit";
      cdr = "cd $(git rev-parse --show-toplevel)";
    };
  };
  programs = {
    git = {
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
        fetch.prune = true;
        init.defaultBranch = "main";
        merge.autoStash = true;
        pull.rebase = true;
        push.autoSetupRemote = true;
        rebase = {
          autoSquash = true;
          autoStash = true;
        };
        submodule.recurse = true;
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
    git-cliff = {
      enable = true;
    };
    lazygit = {
      enable = true;
      settings = {
        gui.nerdFontsVersion = "3";
        git.paging = {
          externalDiffCommand = "difft --color=always --display=side-by-side-show-both";
        };
      };
    };
  };
}
