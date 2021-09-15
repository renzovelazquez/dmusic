#!/bin/bash
DEST_PATH=""

for i in `cat urls01.txt`; do
	youtube-dl --ignore-errors --ignore-config --newline --output "$DEST_PATH/%(title)s.%(ext)s" \
     	--extract-audio --audio-quality 0 \
       	--embed-thumbnail --add-metadata --audio-format mp3 $i;
done
exit