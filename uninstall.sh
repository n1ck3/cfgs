#!/bin/bash

# Make sure you are in the right place. :)
cd
LINKS=( ".pyhistory" ".pystartup" ".vim" ".vimrc" ".zshrc" )
DIRS=( ".cache/vim" ".local/bin" ".local/share" ".logs" "tmp/old_cfgs" )

for i in ${LINKS[@]} ; do
	if [ -f $i ] ; then
		echo "Unlinking: $i"
		unlink $i
	else
		echo "No such link found: $i"
	fi
done

for i in ${DIRS[@]} ; do
	if [ -d $i ] ; then
		echo "deleting directory: $i"
		rm -rf $i
	else
		echo "No such directory found: $i"
	fi
done

chsh -s /bin/bash

echo
echo "Done! \o/"
