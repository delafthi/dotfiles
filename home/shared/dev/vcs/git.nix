{ lib, ... }:
{
  programs.git = {
    enable = true;
    ignores = lib.remove "" (lib.splitString "\n" (builtins.readFile ./ignore));
    settings = {
      alias = {
        a = "add";
        amend = "commit --amend --no-edit";
        b = "branch";
        c = "commit";
        e = "checkout";
        d = "commit --amend";
        cf = "commit --fixup";
        f = "fetch";
        F = "fetch --all";
        l = "!git log --oneline --all --graph || true";
        last = "log -1 HEAD";
        mkpatch = "format-patch -1 HEAD --signoff --stdout";
        p = "push --force-with-lease";
        P = "push --all --force-with-lease";
        st = "status --short --branch --show-stash -unormal";
        unstage = "reset HEAD --";
        undo = "reset HEAD~1 --mixed";
      };
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
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
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
      user = {
        email = "delafthi@pm.me";
        name = "Thierry Delafontaine";
      };
    };
    lfs.enable = true;
    signing = {
      format = "openpgp";
      key = "00926686981863CB";
      signByDefault = false;
    };
  };
}
