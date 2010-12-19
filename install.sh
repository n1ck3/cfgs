#!/bin/bash
# git repo config file installer
# Written by Daethorian (daethorian@ninjaloot.se)
# Customized by n1ck3 (ad.hoc.nick@gmail.com) to work in osx as well as linux
# WTFPL.

FILES_LOC=$(dirname $0)
BACKUP_LOC=$HOME/tmp/old_cfgs

_ins() {
    SRC=$1
    DEST=$2
    if [ ! -L $DEST ] ; then
        if [ ! -d $BACKUP_LOC ] ; then
            mkdir -p $BACKUP_LOC
        fi
        if [ -f $DEST ] || [ -d $DEST ] ; then
            mv -m $DEST $BACKUP_LOC
        fi
        ln -s $SRC $DEST
        echo "$SRC installed"
    else
        echo "$DEST is already installed"
    fi
}

dirs[0]='vim'
dirs[1]='zsh'

for i in ${dirs[@]} ; do
    _ins "$FILES_LOC/${dirs[$i]}" "$HOME/.${dirs[$i]}"
done

# Install vim configs and create directories that
# these configs assume exits
_ins "$FILES_LOC/vim/vimrc" "$HOME/.vimrc"
# Create directories that these configs assume exists
mkdir -p $HOME/.cache/vim/{backup,tmp} $HOME/.logs $HOME/.local/{bin,share} &> /dev/null

# Install zsh configs and change chell to zsh if
# ~/.zshrc installed correclty and user is not root
_ins "$FILES_LOC/zsh/zshrc" "$HOME/.zshrc"
if [[ $(whoami) != "root" && -f $HOME/.zshrc ]] ; then
    chsh -s /bin/zsh
fi

# Install python autocomplete and history
_ins "$FILES_LOC/python/pystartup.py" "$HOME/.pystartup"
_ins "$FILES_LOC/python/pyhistory" "$HOME/.pyhistory"

echo
echo "Done."
if [ -d $BACKUP_LOC ] ; then
    echo "Existing config files were backuped into $BACKUP_LOC"
fi
