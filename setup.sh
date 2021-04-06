#!/bin/sh
#
# ~/.dotfiles/setup.sh

cd $(dirname $0)

configs=(.xinitrc .xprofile .zprofile .tmux.conf)

[[ $1 = "--nobackup" ]] && backup=0 || backup=1

# Backup & linking configs ~/
for e in ${configs[*]} ; do
    [ $backup -eq 1 ] && [ -f ~/$e ] && mv -v ~/$e ~/$e.save.$(date +%Y%m%d%H%M%S)~
    ln -sfTv $(pwd)/$e ~/$e
done

# Backup & linking configs ~/.config
for e in .config/* ; do
    [ $backup -eq 1 ] && [ -d ~/$e ] && mv -v ~/$e ~/$e.save.$(date +%Y%m%d%H%M%S)~
    ln -sfTv $(pwd)/$e ~/$e
done

# Linking scripts ~/.local
for e in .local/bin/* ; do
    ln -sfTv $(pwd)/$e ~/$e
done
