#!/bin/bash
#
# this script will create thumbnails for all png's in the current directory
#

files=`ls *.png 2> /dev/null`

if [ "$files" == "" ]; then
    echo "no png found in current folder"
    exit 1
fi

for file in $files; do 
    # skip if file is already a thumbnail
    echo $file | grep -q small
    if [ $? -eq 0 ]; then
        continue
    fi
    newfile="`echo $file | rev | cut -f2- -d'.'|rev`-small.png"
    if [ -f $newfile ]; then
        echo "Thumbnail $newfile already exists."
        continue
    fi
    convert -adaptive-resize 350x150 $file $newfile
    if [ $? -ne 0 ]; then
        echo "Creation of Thumbnail for $newfile based on $file failed."
        exit 1
    fi 
done