################################################################################
# ~/.config/fish/config.fish: executed by fish for non-login shells.
################################################################################

# General settings {{{1

# Remove greeting message
set fish_greeting

# PS1
function fish_prompt
  set_color $fish_color_user
  echo -n (whoami)
  set_color normal
  echo -n '@'
  set_color $fish_color_host
  echo -n 'TDTPE15'
  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal
  echo -n (fish_vcs_prompt)
  set_color blue
  echo -n '$ '
end

# Set window title
function fish_title
  echo $argv[1]
  pwd
end

# Set vim keybinding
if string match -q 'alacritty' -- $TERM
  # Needs to be set for fish_vi_cursor to work
  set -gx KONSOLE_PROFILE_NAME
end
function fish_user_key_bindings
  fish_vi_cursor
  fish_vi_key_bindings
end

# Set command not found handler to the default one
function fish_command_not_found
  __fish_default_command_not_found_handler $argv
end

# Abbreviations and aliases

# sudo
alias sudo="sudo -s"

# navigation
abbr -a .. "cd .."
abbr -a ... "cd ../.."
abbr -a .3 "cd ../../.."
abbr -a .4 "cd ../../../.."
abbr -a .5 "cd ../../../../.."

# vim like exit
abbr -a :q "exit"

# neovim
alias vim="nvim"
alias vi="nvim"

# Changing "ls" to "exa"
alias ls="exa -al --color=always --group-directories-first"
alias la="exa -a --color=always --group-directories-first"
alias ll="exa -l --color=always --group-directories-first"
alias lt="exa -aT --color=always --group-directories-first"

# Set defaults for bat
alias bat="bat --italic-text=always --color=always --theme TwoDark"

function batgrep --description "Uses ripgrep instead of grep and outputs via bat"
  rg $argv --hidden --color always | bat --paging=never
end
alias grep="batgrep"

function batfind --description "Uses ripgrep --files instead of find and outputs via bat"
  rg $argv --ignore --color=always --smart-case --hidden --files | bat
end
alias find="batfind"

function batdiff --description "Uses bat for a nicer git diff"
  git diff $argv --name-only --diff-filter=d | xargs bat --diff
end

# Use fzf in combination with grep
# fzf colors
alias fzf="fzf \
  --black \
  --color='fg:#dcdfe4,bg:#282c34,fg+:#61afef,bg+:#343944,border:#abb2bf' \
  --color='info:#61afef,spinner:#c678dd,header:#e06c75,prompt:#c678dd' \
  --color='hl:#e5c07b,hl+:#e5c07b,pointer:#c678dd,marker:#e59F70' \
  --color='fg+:reverse,header:bold,pointer:bold,marker:bold,prompt:bold' \
  --color='hl:reverse,hl+:reverse'"

set INITIAL_QUERY ""
set RG_PREFIX "rg --ignore --hidden --column --line-number --with-filename --no-heading --color=always --smart-case "
set FZF_DEFAULT_COMMAND "$RG_PREFIX '$INITIAL_QUERY'"
alias fg="fzf \
  --bind 'change:reload:$RG_PREFIX {q} || true' \
  --disabled \
  --ansi \
  --query '$INITIAL_QUERY' \
  --height=50% \
  --tabstop=2 \
  --layout=reverse \
  --nth=2 \
  --delimiter : \
  --preview-window '+{2}/2' \
  --preview 'bat \
  --style=numbers \
  -r {2}: \
  -H {2} \
  --line-range :500 {1}'"
alias ff="rg \
  --ignore \
  --smart-case \
  --hidden \
  --files | fzf \
  --ansi \
  --height=50% \
  --layout=reverse \
  --tabstop=2 \
  --preview 'bat \
  --style=numbers \
  --line-range :500 {}'"

# adding flags
alias cp="cp -i"                          # confirm before overwriting something
alias df="df -h"                          # human-readable sizes
alias free="free -m"                      # show sizes in MB
alias rm="rm -i"
alias mv="mv -i"
alias minicom="minicom -m -c on"
alias htop="htop -t"

# shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

# kitty specific aliases
if string match -q "xterm-kitty" -- $TERM
  alias ssh="kitty +kitten ssh"
end

# Environment variables {{{1

# set vim as the manpager
set -gx MANPAGER "nvim +Man!"
set -gx EDITOR "nvim" # $EDITOR use Neovim in terminal
set -gx SSH_KEY_PATH "~/.ssh/rsa_id" # Set default ssh key path
set -gx GCC_COLORS "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# Path
if test -d $HOME/.bin
  set -gx PATH $HOME/.bin $PATH
end

if test -d $HOME/.local/bin
  set -gx PATH $HOME/.local/bin $PATH
end

# Visuals {{{1

# Vi mode prompt
function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color green
      echo '[NORMAL]'
    case insert
      echo ''
    case replace_one
      set_color green
      echo '[NORMAL]'
    case replace
      set_color red
      echo '[REPLACE]'
    case visual
      set_color yellow
      echo '[VISUAL]'
    case '*'
      set_color --bold red
      echo '[???]'
  end
  set_color normal
end

# Set the fish syntax highlighting colors
set fish_color_normal white
set fish_color_command magenta
set fish_color_quote green
set fish_color_redirection blue
set fish_color_end white
set fish_color_error red --bold
set fish_color_param white
set fish_color_comment brblack --italics
set fish_color_match cyan --bold
set fish_color_selection --reverse
set fish_color_search_match --reverse
set fish_color_operator yellow
set fish_color_escape yellow
set fish_color_cwd yellow
set fish_color_autosuggestion brblack --italics
set fish_color_user blue
set fish_color_host blue
set fish_color_host_remote purple
set fish_color_cancel red

# Vi cursor style
set fish_cursor_default block
set fish_cursor_visual block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore

# VCS config
set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showcolorhints
set __fish_git_prompt_color green
set __fish_git_prompt_color_prefix green
set __fish_git_prompt_color_suffix green
set __fish_git_prompt_color_bare yellow
set __fish_git_prompt_color_merging brred
set __fish_git_prompt_color_cleanstate green
set __fish_git_prompt_color_dirtystate red
set __fish_git_prompt_char_dirtystate ''
set __fish_git_prompt_color_stagedstate cyan
set __fish_git_prompt_char_stagedstate ''
set __fish_git_prompt_color_untrackedfiles yellow
set __fish_git_prompt_color_upstream magenta
set __fish_git_prompt_color_branch green
set __fish_git_prompt_color_branch_detached red --bold

# Functions {{{1

function ex --description "Function to extract most types of archives"
  if test -f $argv
    switch $argv
      case --help
        echo "usage: ex <file>"
      case '*.tar.bz2'
        tar xjf $argv
      case '*.tar.gz'
        tar xzf $argv
      case '*.bz2'
        bunzip2 $argv
      case '*.rar'
        unrar x $argv
      case '*.gz'
        gunzip $argv
      case '*.tar'
        tar xf $argv
      case '*.tbz2'
        tar xjf $argv
      case '*.tgz'
        tar xzf $argv
      case '*.zip'
        unzip $argv
      case '*.Z'
        uncompress $argv
      case '*.7z'
        7z x $argv
      case '*.deb'
        tar x $argv
      case '*.tar.xz'
        tar xf $argv
      case '*.tar.zst'
        unzstd $argv
      case '*'
        echo "'$argv' cannot be extracted via ex"
    end
  else
    echo "'$argv' is not a valid file"
  end
end

function nofunc --description "Run command ignoring functions and aliases"
  functions -c $argv[1] functionholder
  functions --erase $argv[1]
  $argv
  functions -c functionholder $argv[1]
  functions --erase functionholder
end

# Plugins {{{1
if not test -d $HOME/.config/fish/plugins
  mkdir -p $HOME/.config/fish/plugins
end

# Starship prompt
# Change default config directory
if not command -v  starship 1>/dev/null 2>&1
  set_color --bold red
  echo -n "=> Error: "
  set_color normal
  echo -e "Starship not installed.\n"
  set_color --bold green
  echo -n "=> Info: "
  set_color normal
  echo "Starship will be downloaded and installed."
  curl -fsSL https://starship.rs/install.sh | bash
end
set -gx STARSHIP_CONFIG $HOME/.config/starship/starship.toml
starship init fish | source

# foreign-env
if not test -d $HOME/.config/fish/plugins/foreign-env
  mkdir -p $HOME/.config/fish/plugins/foreign-env
  git clone https://github.com/oh-my-fish/plugin-foreign-env $HOME/.config/fish/plugins/foreign-env
end
  set fish_function_path $fish_function_path $HOME/.config/fish/plugins/foreign-env/functions

# Nix
# has to be defined aftet foreign-env
if test -f /etc/profile.d/nix.sh
  fenv source /etc/profile.d/nix.sh
end

# pyenv
if command -v pyenv 1>/dev/null 2>&1
  pyenv init --path | source
  if not test -d $PYENV_ROOT/plugins/pyenv-virtualenv
    set_color --bold red
    echo -n "=> Error: "
    set_color normal
    echo -e "pyenv-virtualenv not installed.\n"
    set_color --bold green
    echo -n "=> Info: "
    set_color normal
    echo "pyenv-virtualenv will be downloaded and installed."
    mkdir -p $PYENV_ROOT/plugins/pyenv-virtualenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git $PYENV_ROOT/plugins/pyenv-virtualenv
  end
  pyenv init - | source
  pyenv virtualenv-init - | source
end
