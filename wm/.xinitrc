#!/bin/sh

userresources=$HOME/.Xresources
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Start some programs
xsetroot -cursor_name left_ptr
xss-lock --transfer-sleep-lock -- i3lock -c 282C34 --nofork &
picom &

# Default session
export SXHKD_SHELL="/usr/bin/sh"
session=${2:-bspwm}
case $session in
bspwm) exec bspwm ;;
# If the session is not known, try to execute it as command
*) exec $1 ;;
esac
