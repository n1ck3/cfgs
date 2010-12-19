#!/bin/bash

# Make sure you are in the right place. :)
cd
LINKS=( ".pyhistory" ".pystartup" ".vim" ".vimrc" ".zshrc" )
DIRS=( ".cache/vim" ".local/bin" ".local/share" ".logs" )

echo "* Removing softlinks"
for i in ${LINKS[@]} ; do
    if [ -L $i ] ; then
        echo "      - Unlinking: $i"
        unlink $i
    fi
done

echo "* Removing directories"
for i in ${DIRS[@]} ; do
    if [ -d $i ] ; then
        echo "      - Removing: $i"
        rm -rf $i
    fi
done

chsh -s /bin/bash

echo
echo "Done!!1 \o/"

