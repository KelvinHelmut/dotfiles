# 

alias aek6='~/.aek6/scripts/wminit'
[[ -z $DISPLAY && $XDG_VTNR -le 5 ]] && aek6 && exec startx &> /dev/null
