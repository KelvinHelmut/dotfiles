#!/bin/sh
#
# ~/.xinitrc

WM=i3

# QT icons
export DESKTOP_SESSION=gnome

# Load profile
# . '/etc/profile'

# Load resources
xrdb -nocpp -merge ~/.Xresources &

# Login
# feh --bg-fill ~/.DOTFILES/start.png --no-fehbg &
# . "$HOME/.DOTFILES/scripts/key"

# Load profile
. "$HOME/.xprofile" $WM

# Run all system xinitrc shell scripts
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

exec $WM
