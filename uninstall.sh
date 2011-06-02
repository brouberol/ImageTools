#!/bin/bash

PREFIX="/usr/local"

INSTALLDIR="$PREFIX/share/imagetools"
BINDIR="$PREFIX/bin"


# Are we root?
if [[ $EUID -ne 0 ]]; then
    echo "You must be root to run this script." 2>&1
    exit 1
else
	
	rm -r $INSTALLDIR
	rm $BINDIR/it-resize
	rm $BINDIR/it-grayscale

	echo "ImageTools have been successfully uninstalled."
	
fi
