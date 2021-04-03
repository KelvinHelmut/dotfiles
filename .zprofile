#!/bin/sh
#
# ~/.zprofile

# Automatic start WM on login
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1
