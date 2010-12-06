#!/bin/bash
# git repo config file installer
# Written by Daethorian (daethorian@ninjaloot.se)
# Customized by n1ck3 (ad.hoc.n1ck3@gmail.com) to work in osx
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

_ins "$FILES_LOC/vim/vimrc" "$HOME/.vimrc"
_ins "$FILES_LOC/zsh/zshrc" "$HOME/.zshrc"

# Create directories that these configs assume exists
mkdir -p $HOME/.cache/vim/{backup,tmp} $HOME/.logs $HOME/.local/{bin,share} &> /dev/null

echo
echo "Done."
echo "Existing config files were backuped into $BACKUP_LOC"
