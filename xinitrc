#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

export DOTFILES=$HOME/.DOTFILES

# WM=`cat ~/.xinitwm`
WM=i3

if [ -f $HOME/.Xresources ]; then
    xrdb -nocpp -merge $HOME/.Xresources
fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#numlockx on &
feh --bg-fill $DOTFILES/start.png --no-fehbg
$DOTFILES/scripts/key

while : ; do 
    pacman -Sy 1>/dev/null 2>&1
    sleep 7000
done &

$HOME/.xprofile $WM &
exec $WM
