#!/bin/bash

# --- This script pastes a watermark in all pictures located in the same directory ---

# Check for arguments	
if [ $# = 1 ]; then
	DIR="$1"
else
	DIR="./"
fi

#Init variables
WATER_PATH=`zenity --file-selection --title="Select your watermark file"`
SUBDIR="Watermarked/"
PROGRESS=0
FILES=`ls $DIR | egrep '(.JPG)|(.jpg)|(.png)|(.raw)|(.tiff)'`
NB_FILES=`ls $DIR | egrep '(.JPG)|(.jpg)|(.png)|(.raw)|(.tiff)' | wc -l`

# If picture files in directory
if [ $NB_FILES -ne 0 ]; then

	INCREMENT=$[100/$NB_FILES]
	mkdir -p $DIR$SUBDIR

	# Creating thumbnails. Specific work on picture should be add there as convert's option
	(for i in $FILES; do
	    echo "$PROGRESS"; # a line with no # updates the percentage
	    echo "# Watermarking $i" # a line beginning with # updates the text field
	    composite -gravity center -dissolve 15 $WATER_PATH "$DIR${i}" "$DIR$SUBDIR${i}"
	    let "PROGRESS+=$INCREMENT"
	done
	) | zenity --progress --percentage=0 --auto-close --title="Creating thumbnails..."

else
	echo "No image files in $DIR directory"

fi


