#!/bin/bash

# Make sure you are in the right place. :)
cd
LINKS=( ".pystartup" ".vim" ".vimrc" ".zshrc" )
FILES=( ".cache/vim" ".local/bin" ".local/share" ".pyhistory" ".logs" )

echo "* Removing softlinks"
for i in ${LINKS[@]} ; do
    if [ -L $i ] ; then
        echo "      - Unlinking: $i"
        unlink $i
    fi
done

echo "* Removing files"
for i in ${DIRS[@]} ; do
    if [ -d $i ] || [ -f $i ] ; then
        echo "      - Removing: $i"
        rm -rf $i
    fi
done

chsh -s /bin/bash

echo
echo "Done!!1 \o/"
