#!/bin/bash
# git repo config file installer
# Written by Daethorian (daethorian@ninjaloot.se)
# Customized by n1ck3 (ad.hoc.nick@gmail.com) to work in osx as well as linux
# WTFPL.

# Make sure you are in the right place. :)
cd
FILES_LOC=$(dirname $0)
BACKUP_LOC=$HOME/tmp/old_cfgs
BACKED_UP="no"

# Install method
_ins() {
    SRC=$1
    DEST=$2
    if [ -L $DEST ] || [ -f $DEST ] || [ -d $DEST ] ; then
        # Already there? Deal with it.
        if [ -L $DEST ] ; then
            MSG="      - Reinstalling ${SRC}"
            unlink $DEST
        elif [ -f $DEST ] ; then
            if [ ! -d $BACKUP_LOC ] ; then
                mkdir -p $BACKUP_LOC
            fi
            MSG="      - Reinstalling $SRC"
            mv $DEST $BACKUP_LOC
            BACKED_UP="yes"
        fi
    else
        MSG="      - Installing ${SRC}"

    fi
    echo "$MSG"
    ln -s $SRC $DEST
}

# Install vim configs and create directories that
# these configs assume exits
echo "* Installing vim configs"
_ins "$FILES_LOC/vim/vimrc" "$HOME/.vimrc"
_ins "$FILES_LOC/vim" "$HOME/.vim"
# Create directories that these configs assume exists
mkdir -p $HOME/.cache/vim/{backup,tmp} $HOME/.logs $HOME/.local/{bin,share} &> /dev/null

# Install python autocomplete and history
echo "* Installing ppython configs"
_ins "$FILES_LOC/python/pystartup.py" "$HOME/.pystartup"
touch "$HOME/.pyhistory"

# Install zsh configs and change chell to zsh if
# ~/.zshrc installed correclty and user is not root
echo "* Installing zsh configs"
_ins "$FILES_LOC/zsh/zshrc" "$HOME/.zshrc"
if [ $(whoami) != "root" ] && [ -L $HOME/.zshrc ] ; then
    chsh -s /bin/zsh
fi

if [ $BACKED_UP = "yes" ] ; then
    echo
    echo "Existing config files were backed up into $BACKUP_LOC"
fi

echo
echo "Done!!1 \o/"
