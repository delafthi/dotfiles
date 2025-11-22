{ pkgs, ... }:
{
  home.packages = with pkgs; [ gh ];
  programs.git = {
    enable = true;
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
      key = "00926686981863CB";
      signByDefault = true;
    };
    ignores = [
      # github/gitignores/Global/Archives.gitignore
      # It's better to unpack these files and commit the raw source because
      # git has its own built in compression methods.
      "*.7z"
      "*.jar"
      "*.rar"
      "*.zip"
      "*.gz"
      "*.gzip"
      "*.tgz"
      "*.bzip"
      "*.bzip2"
      "*.bz2"
      "*.xz"
      "*.lzma"
      "*.cab"
      "*.xar"
      "*.zst"
      "*.tzst"
      # Packing-only formats
      "*.iso"
      "*.tar"
      # Package management formats
      "*.dmg"
      "*.xpi"
      "*.gem"
      "*.egg"
      "*.deb"
      "*.rpm"
      "*.msi"
      "*.msm"
      "*.msp"
      "*.txz"

      # github/gitignores/Global/Backup.gitignore
      "*.bak"
      "*.gho"
      "*.ori"
      "*.orig"
      "*.tmp"

      # github/gitignores/Global/GPG.gitignore
      "secring.*"

      # github/gitignores/Global/Linux.gitignore
      "*~"
      # temporary files which can be created if a process still has a handle open of a deleted file
      ".fuse_hidden*"
      # Metadata left by Dolphin file manager, which comes with KDE Plasma
      ".directory"
      # Linux trash folder which might appear on any partition or disk
      ".Trash-*"
      # .nfs files are created when an open file is removed but is still being accessed
      ".nfs*"
      # Log files created by default by the nohup command
      "nohup.out"

      # github/gitignores/Global/macOS.gitignore
      # General
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"
      # Thumbnails
      "._*"
      # Files that might appear in the root of a volume
      ".DocumentRevisions-V100"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ".com.apple.timemachine.donotpresent"
      # Directories potentially created on remote AFP share
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"

      # github/gitignores/Global/SVN.gitignore
      ".svn/"

      # github/gitignores/Global/Syncthing.gitignore
      # Syncthing caches
      ".stversions"

      # github/gitignores/Global/Tags.gitignore
      # Ignore tags created by etags, ctags, gtags (GNU global) and cscope
      "TAGS"
      ".TAGS"
      "!TAGS/"
      "tags"
      ".tags"
      "!tags/"
      "gtags.files"
      "GTAGS"
      "GRTAGS"
      "GPATH"
      "GSYMS"
      "cscope.files"
      "cscope.out"
      "cscope.in.out"
      "cscope.po.out"

      # github/gitignores/Global/VirtualEnv.gitignore
      ".venv"

      # Other common directories I don't want to be included
      ".cache"
      ".direnv"
      ".env"
      ".git"
      ".helix"
      ".jj"
      ".opencode"
      "compile_commands.json"
      "result"
    ];
  };
}
