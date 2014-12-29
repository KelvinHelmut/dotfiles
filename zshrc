# {{{ ZSH Stuff
# {{{ Autoload ZSH Modules When They Are Referenced

zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof

# }}}

# {{{ Completions
zstyle ':completion:*' format '..... %d .....'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*' ignore-parents parent pwd
zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for:%b %d'
# zstyle ':completion:*' menu select
zstyle ':completion:*:default' menu 'select=0'
zstyle ':completion:*' file-sort modification reverse

export EDITOR="/usr/bin/vim"
# }}}

# {{{ Load ZSH Modules

bindkey -e
autoload -Uz compinit zcalc zsh-mime-setup colors
compinit
autoload -U promptinit
promptinit

# }}}

# {{{ History

HISTFILE=~/.zsh/history
HISTSIZE=1000
SAVEHIST=10000
setopt EXTENDED_HISTORY		# puts timestamps in the history
setopt HIST_VERIFY			# when using ! cmds, confirm first
setopt HIST_IGNORE_DUPS		# ignore same commands run twice+
setopt APPEND_HISTORY		# don't overwrite history 
setopt SHARE_HISTORY		# _all_ zsh sessions share the same history files
setopt INC_APPEND_HISTORY	# write after each command

# }}}

# {{{ Options

setopt PUSHD_MINUS
setopt NO_HUP
setopt NO_BEEP
setopt NO_CASE_GLOB
# setopt IGNORE_EOF
setopt ALL_EXPORT
setopt notify pushdtohome cdablevars autolist
setopt recexact longlistjobs
setopt autoresume histignoredups pushdsilent 
setopt autopushd pushdminus
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt autocd
setopt extendedglob
unsetopt bgnice autoparamslash

# }}}
# }}}

# {{{ Aliases
# {{{ CD/DVD Options
alias mount-iso='sudo mount -o loop'
# }}}

# {{{ Info
alias bootime='sudo systemd-analyze'
alias bootservice='sudo systemd-analyze blame'

alias start='sudo systemctl start'
alias restart='sudo systemctl restart'
alias stop='sudo systemctl stop'

# }}}

# {{{ Managing
alias pacman='pacman --color=always'
alias update='packer -Syu'
alias install='pacman -S'
alias install+='packer -S'
alias remove='sudo pacman --color always -Rsnc'
alias search='pacman -Ss' 
alias search+='packer -Ss' 
alias infop='pacman -Qi'
alias unlock='rm /var/lib/pacman/db.lck'
# }}}

# {{{ Multimedia
alias m='ncmpcpp'
# }}}

# {{{ System
alias c='clear'
alias ls='ls --color=auto -A'
alias ll='ls -l'
alias la='ls -a'
alias reload='clear && source ~/.zshrc'
alias rm='sudo rm -rv'
alias cp='cp -rv'
alias mv='mv -vi'
alias open='xdg-open'
alias ':q'='exit'
# }}}

# {{{ Tmux
# [ "$TERM" = screen ] && export TERM=screen-256color

# if [[ -z "$TMUX" ]]; then
#         tmux 
# fi
# }}}

alias alsi='alsi -a -u -c'
alias mysql='mysql -uroot -p'
alias wine32='WINEARCH=win32 WINEPREFIX=~/.wine32 wine'
# }}}

# {{{ Custom Prompt
PROMPT="%F{green}┌────╼%f %F{blue}%~ %f
%F{green}└─╼%f %F{green}%B$%b%f  "
RPROMPT="%F{cyan}%*%f"
# }}}

# {{{ Color Support
eval "`dircolors -b $HOME/.zsh/LS_COLORS`"
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
export LS_COLORS

# man color {{{
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
# }}}

# Maven {{{
# Colorize Maven Output
# Colors reference: http://en.wikipedia.org/wiki/ANSI_escape_code
color_maven() {
  $M2_HOME/bin/mvn $* | sed \
    -e 's/Tests run: \([^,]*\), Failures: \([^,]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/[32;1mTests run: \1[0m, Failures: [31;1m\2[0m, Errors: [33;1m\3[0m, Skipped: [34;1m\4[0m/g' \
    -e 's/\(\[INFO\] \-[-]*$\)/[36;1m\1[0m/g' \
    -e 's/\(\[INFO\] Building.*\)/[36;1m\1[0m/g' \
    -e 's/\(.*WARN.*\)/[33;1m\1[0m/g' \
    -e 's/\(.*ERROR.*\)/[31;1m\1[0m/g' \
    -e 's/\(Downloaded:.*\)/[32;1m\1[0m/g'
}
alias mvn=color_maven
alias maven=$M2_HOME/bin/mvn
# }}}

# }}}

# {{{ Functions
# {{{ Config

config () {
    case $1 in  
        i3)         $EDITOR ~/.i3/config;;
        awesome)    $EDITOR ~/.config/awesome/rc.lua ;;
        boot)       sudo $EDITOR /boot/grub/grub.cfg ;;
        fstab)      sudo $EDITOR /etc/fstab ;;
        grub)       sudo $EDITOR /etc/default/grub ;;
        hosts)      sudo $EDITOR /etc/hosts ;;
        init)       sudo $EDITOR /etc/mkinitcpio.conf ;;
        ls)         $EDITOR ~/.LS_COLORS ;;
        mpd)        sudo $EDITOR ~/.mpd/mpd.conf ;;
        mplayer)    sudo $EDITOR ~/.mplayer/config ;;
        music)      $EDITOR ~/.ncmpcpp/config ;;
        open)       $EDITOR ~/.local/share/applications/mimeapps.list ;;
		pacman)		sudo $EDITOR /etc/pacman.conf ;;
        ssh)        sudo $EDITOR /etc/ssh/ssh_config ;;
        sshd)       sudo $EDITOR /etc/ssh/sshd_config ;;
        tmux)       $EDITOR ~/.tmux.conf ;;
        vim)        $EDITOR ~/.vimrc ;;
        xinit)      $EDITOR ~/.xinitrc ;;
        zsh)        $EDITOR ~/.zshrc ;;
        *)          if [ -f "$1" ]; then
						if [ -w "$1" ]; then		
							$EDITOR "$1"
						else
							sudo $EDITOR "$1"
						fi
					else 
						echo "Invalid Option" 
					fi ;;
   esac
}

# }}}
# }}}

# {{{ Startup Functions
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-syntax-highlighting/06-syntax-rules.zsh
# }}}

# Keys {{{
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi
# }}}
