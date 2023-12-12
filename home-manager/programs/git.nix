{
  programs.git = {
    enable = true;
    aliases = {
      br = "branch";
      co = "checkout";
      c = "commit";
      can = "commit --amend --no-edit";
      ca = "commit --amend";
      hist = "log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short";
      last = "log -1 HEAD";
      save = "!git add -A && git commit -m 'chore: WIP'";
      st = "status -s -u -b --show-stash";
      unstage = "reset HEAD --";
      undo = "reset HEAD~1 --mixed";
    };
    diff-so-fancy = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
    };
    ignores = [
      ".cache"
      ".direnv/"
      ".envrc"
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
      signByDefault= true;
    };
    userEmail = "thierry@delafontaine.xyz";
    userName = "Thierry Delafontaine";
  };
  programs.git-cliff = {
    enable = true;
  };
}
