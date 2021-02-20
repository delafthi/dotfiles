# ~/.zshrc: executed by zsh(1) for non-login shells.

################################################################################
# Zsh settings
################################################################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# set vim as manpager
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist noma' -\""

# Enable autocompletion for hidden files
_comp_options+=(globdots)
ZSH_AUTOSUGGEST_USE_ASYNC=1

################################################################################
# Aiases

alias sudo="sudo "

# navigation
alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."

# vim
alias vim="nvim"
alias vi="nvim"
alias :q="exit"

# Changing "ls" to "exa"
alias ls="exa -al --color=always --group-directories-first"
alias la="exa -a --color=always --group-directories-first"  # all files and dirs
alias ll="exa -l --color=always --group-directories-first"  # long format
alias lt="exa -aT --color=always --group-directories-first" # tree listing

# Colorize grep output and changing it to ripgrep
alias grep="grep --color=auto"

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
if [ $TERM == "xterm-kitty" ]
then
    alias ssh="kitty +kitten ssh"
fi

################################################################################
# Environment variables
export HISTCONTROL=ignoreboth             # no duplicate entries
export HISTSIZE=5000
export HISTFILESIZE=10000
export EDITOR="nvim"                      # $EDITOR use Neovim in terminal
export SSH_KEY_PATH="~/.ssh/rsa_id"       # Set default ssh key path
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# Path
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

################################################################################
# Keybindings

# Set vi mode
bindkey -v

################################################################################
# Visuals

# Colors
COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[0;32m"
COLOR_BLUE="\033[0;34m"
COLOR_YELLOW="\033[0;33m"
COLOR_PURPLE="\033[0;35m"
COLOR_CYAN="\033[0;36m"
COLOR_RESET="\033[0m"

# Prompt
color_prompt=yes
PS1="\[$COLOR_PURPLE\]\u@\h:\[$COLOR_YELLOW\]\w"
if [ -e /etc/bash_completion.d/git-prompt ]; then
    PS1+="\[\$(git_color)\]"        # colors git status
    PS1+="\$(__git_ps1)"            # prints current branch
fi
PS1+="\[$COLOR_BLUE\]\$\[$COLOR_RESET\] "   # '#' for root, else '$'

# Change title of terminals
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND="echo -ne '\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007'" ;;
  screen*)
    PROMPT_COMMAND="echo -ne '\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\'" ;;
esac

################################################################################
# Functions

# Archive extraction
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      --help)      echo "usage: ex <file>" ;;
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

################################################################################
# Plugins

# Starship prompt
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
if [[ $(type -t starship) == "file" ]]; then
    eval "$(starship init zsh)"
else
    echo -e "$COLOR_RED $BOLD => Error: $COLOR_RESET $NORMAL Starship not installed.\n"
    echo -e "$COLOR_GREEN $BOLD => Info: $COLOR_RESET $NORMAL Starship will be downloaded and installed in the following steps"
    curl -fsSL https://starship.rs/install.sh | bash && \
        eval "$(starship init zsh)"
fi

# Nix
if [ -f /etc/profile.d/nix.sh ]; then
  source /etc/profile.d/nix.sh
fi

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi
