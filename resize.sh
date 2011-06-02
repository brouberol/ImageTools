#!/bin/bash

# --- This script applies a scale-resize function to all pictures in the same directory ---

# Check for arguments	
if [ $# = 1 ]; then
	DIR="$1"
else
	DIR="./"
fi

#Init variables
PROGRESS=0
FILES=`ls $DIR | egrep '(.JPG)|(.jpg)|(.png)|(.raw)|(.tiff)'`
NB_FILES=`ls $DIR | egrep '(.JPG)|(.jpg)|(.png)|(.raw)|(.tiff)' | wc -l`

# If picture files in directory
if [ $NB_FILES -ne 0 ]; then

	# Dialog box to choose thumb's size
	SIZE=`zenity --scale --text="Choose scale of resized images" --min-value=1 --max-value=100 --step=1 --value=50`

	if [ "$SIZE" != "" ]; then # If user haven't clicked on 'Cancel'

		INCREMENT=$[100/$NB_FILES]
		mkdir -p $DIR"Resized"

		# Creating thumbnails. Specific work on picture should be add there as convert's option
		(for i in $FILES; do
		    echo "$PROGRESS"; # a line with no # updates the percentage
		    echo "# Resizing $i" # a line beginning with # updates the text field
		    convert -resize "$SIZE%" "$DIR${i}" "$DIR"Resized/"${i}"
		    let "PROGRESS+=$INCREMENT"
		done
		) | zenity --progress --percentage=0 --auto-close --title="Creating thumbnails..."

	fi

else
	echo "No image files in $DIR directory"

fi
