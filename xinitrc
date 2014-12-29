#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

WM=`cat ~/.xinitwm`

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi


numlockx on &
xrdb -nocpp -merge ~/.Xresources &

# .aek6/scripts/key

sh ~/.xprofile $WM &

exec $WM
