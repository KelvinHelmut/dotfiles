#!/bin/sh

export PATH="${PATH}:$HOME/.bin"

#alias aek6='~/.aek6/scripts/wminit'
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1
if [[ -z $DISPLAY && $XDG_VTNR -le 4 ]]; then
    # exec startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1
fi
