#!/bin/bash

PREFIX="/usr/local"

INSTALLDIR="$PREFIX/share/imagetools"
BINDIR="$PREFIX/bin"


# Are we root?
if [[ $EUID -ne 0 ]]; then
    echo "You must be root to run this script." 2>&1
    exit 1
else
	
	mkdir -p "$INSTALLDIR"
	cp resize.sh grayscale.sh watermark.sh convert.sh "$INSTALLDIR/"
	ln -s "$INSTALLDIR/resize.sh" "$BINDIR/it-resize"
	ln -s "$INSTALLDIR/grayscale.sh" "$BINDIR/it-grayscale"
	ln -s "$INSTALLDIR/watermark.sh" "$BINDIR/it-watermark"
	ln -s "$INSTALLDIR/convert.sh" "$BINDIR/it-convert"
	chmod +x "$BINDIR/it-grayscale" 
	chmod +x "$BINDIR/it-resize"
	chmod +x "$BINDIR/it-watermark"
	chmod +x "$BINDIR/it-convert"

	echo -e "ImageTools bin files located in $BINDIR/ directory"
fi
