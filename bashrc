#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
# PS1='[\W]\$ '
PS1='\[\e[0;32m\]\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\]\[\e[0;37m\] '
 
alias alsi='alsi -a -u' 
alias aek6='~/.aek6/scripts/wminit'
alias servicios='~/.aek6/scripts/servicios.sh'

export EDITOR="vim"

# alias xtmux="TERM=screen-256color-bce exec tmux"
# [[ -z "$TMUX" ]] && TERM=screen-256color-bce exec tmux
# [ -n "$XTERM_VERSION" ] && transset-df -a 0.92 >/dev/null

man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}
