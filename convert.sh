#!/bin/bash

# --- This script applies a black&white conversion function to all pictures in the same directory ---

if [ $# = 2 ]; then
	DIR="$1"	
	FINAL_FORMAT="$2"
else
	DIR="./"
	FINAL_FORMAT="$1"
fi

SUBDIR="Convert_"$FINAL_FORMAT"/"
PROGRESS=0
FILES=`ls $DIR | egrep '(\.JPG$)|(\.jpg$)|(\.png$)|(\.raw$)|(\.tiff$)'`
NB_FILES=`ls $DIR | egrep '(\.JPG$)|(\.jpg$)|(\.png$)|(\.raw$)|(\.tiff$)' | wc -l`

if [ $NB_FILES -ne 0 ]; then

	INCREMENT=$[100/$NB_FILES]

	mkdir -p $DIR$SUBDIR

	# Creating thumbnails. Specific work on picture should be add there as convert's option
	(for i in $FILES; do
	    echo "$PROGRESS"; # a line with no # updates the percentage
	    echo "# Converting $i to "$FINAL_FORMAT"" # a line beginning with # updates the text field
	    FILENAME=`echo $i | sed 's/\.[^\.]*$//'` #removing the extension
	    convert "$DIR${i}" "$DIR$SUBDIR$FILENAME.$FINAL_FORMAT"
	    let "PROGRESS+=$INCREMENT"
	done
	) | zenity --progress --percentage=0 --auto-close --title="Creating thumbnails..."

else
	echo "No image files in $DIR directory."
fi
