#!/bin/sh
#
# ~/.xinitrc

export WM=i3
export $(dbus-launch)
export DESKTOP_SESSION=gnome                                    # QT icons

hsetroot -solid "#000000" &                                     # Black screen

[ -f ~/.Xresources ] && xrdb -nocpp -merge ~/.Xresources &      # Load resources
[ -f ~/.xprofile ] && . ~/.xprofile                             # Load profile

# Run all system xinitrc shell scripts
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

exec $WM
