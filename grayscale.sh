#!/bin/bash

# --- This script applies a black&white conversion function to all pictures in the same directory ---


if [ $# = 1 ]; then
	DIR="$1"
else
	DIR="./"
fi

SUBDIR="GrayScale/"
PROGRESS=0
FILES=`ls $DIR | egrep '(.JPG)|(.jpg)|(.png)|(.raw)|(.tiff)'`
NB_FILES=`ls $DIR | egrep '(.JPG)|(.jpg)|(.png)|(.raw)|(.tiff)' | wc -l`

if [ $NB_FILES -ne 0 ]; then

	INCREMENT=$[100/$NB_FILES]

	mkdir -p $DIR$SUBDIR

	# Creating thumbnails. Specific work on picture should be add there as convert's option
	(for i in $FILES; do
	    echo "$PROGRESS"; # a line with no # updates the percentage
	    echo "# Converting $i to grayscale" # a line beginning with # updates the text field

	    convert  "$DIR${i}" -colorspace Gray "$DIR$SUBDIR${i}"
	    let "PROGRESS+=$INCREMENT"
	done
	) | zenity --progress --percentage=0 --auto-close --title="Creating thumbnails..."

else
	echo "No image files in $DIR directory."
fi
