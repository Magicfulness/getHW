#!/bin/bash

# ********************************
# *** OPTIONS
# ********************************
# Set this to the directory you want files saved. End with / please
SAVE_DIR=~/Documents/Coursework/
# Set this to full homepage of course you want to download from. End with / please
HOME=CHANGEME
# Set this to the file type you want to grab TODO: add support for multiple file types
FILE_TYPE=pdf
# For people who know how to use bash regex, specify file pattern
FILE_PAT="hw[[:digit:]]*\.$FILE_TYPE"
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

# Cleanup downloaded course page
if [ -e "/tmp/coursesite.html" ]; then
    rm /tmp/coursesite.html
fi
