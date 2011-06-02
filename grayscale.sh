#!/bin/bash

# How many files to make the progress bar
PROGRESS=0
if [ $# = 1 ]; then
	DIR="$1"
else
	DIR="./"
fi
SUBDIR="GrayScale/"

FILES=`ls $DIR | egrep '(.JPG)|(.jpg)|(.png)|(.raw)|(.tiff)'`
NB_FILES=`ls $DIR | egrep '(.JPG)|(.jpg)|(.png)|(.raw)|(.tiff)' | wc -l`
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
