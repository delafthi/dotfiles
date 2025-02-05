{ lib
, pkgs
, tokyonight
}: {
  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type d --hidden --strip-cwd-prefix --exclude .git";
    changeDirWidgetOptions = [
      "--preview= '${pkgs.eza}/bin/eza --tree --color=always {} | head -200'"
    ];
    defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    defaultOptions = (lib.lists.dropEnd 1
      (lib.lists.drop 1
        (lib.strings.splitString " \\\n"
          (builtins.readFile "${tokyonight}/extras/fzf/tokyonight_night.sh"))));
    fileWidgetCommand = "fd --type f --hidden --strip-cwd-prefix --exclude .git";
    fileWidgetOptions = [
      "--preview 'bat -n --color=always --line-range :500 {}'"
    ];
  };
}
