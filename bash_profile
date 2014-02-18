#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

ln -fs ~/.aek6/i3/xinitrc ~/.xinitrc

[[ -z $DISPLAY && $XDG_VTNR -le 3 && $(fgconsole 2>/dev/null) == 1 ]] && exec startx &> /dev/null

[[ -z $DISPLAY && $XDG_VTNR -le 3 && $(fgconsole 2>/dev/null) == 2 ]] && aek6 && exec startx &> /dev/null
