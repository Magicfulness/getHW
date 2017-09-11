#!/bin/bash

# ********************************
# *** OPTIONS
# ********************************
# Set this to the directory you want files saved. End with / please
SAVE_DIR=~/Documents/Coursework/
# Set this to full homepage of course you want to download from. End with / please
HOME=http://www.eecs70.org/
# Set this to the file types you want to grab. Add more if you want to grab more types.
FILE_TYPES[0]=pdf
#FILE_TYPES[1]=tex
#FILE_TYPES[2]=
# For people who know how to use bash regex, specify file pattern
FILE_PAT_PRE="hw[[:digit:]]*\."
# For grabbing sols
#FILE_PAT_PRE="hw[[:digit:]]*sol\."
# ********************************
# *** Main
# ********************************

if [ $HOME == "CHANGEME" ]; then
	echo "Please change default options."
	exit
fi
mkdir -p $SAVE_DIR

# Download course page to find links to files
wget $HOME -O /tmp/coursesite.html

for FILE_TYPE in "${FILE_TYPES[@]}"; do
    FILE_PAT=$FILE_PAT_PRE$FILE_TYPE
    # Unneccessarily complicated regexing through the course page to find links to hw
    HW_REG="<a[[:blank:]]href=\"\($HOME\)\?\/\?\([[:alnum:]]\+\/\)\+$FILE_PAT\">"
    URL_REG="\/.*$FILE_TYPE"
    SITE=$(grep -o $HW_REG /tmp/coursesite.html | grep -o $URL_REG)

    for URL in $SITE; do
	    FILE_NAME=$(echo $URL | grep -o $FILE_PAT)
	    #echo $FILE_NAME
	    if [ -f $SAVE_DIR$FILE_NAME ]; then
	    	echo "$FILE_NAME exists"
	    else
	    	wget $HOME$URL -O $SAVE_DIR$FILE_NAME
	    fi
    done
done

# Cleanup downloaded course page
if [ -e "/tmp/coursesite.html" ]; then
    rm /tmp/coursesite.html
fi
