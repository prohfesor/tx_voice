#!/bin/bash
LANG=de

while read LINE; do
 FILENAME=${LINE//[^a-zA-Z0-9]/_}
 FILENAME="${FILENAME,,}"
 echo "$LINE -> $FILENAME"
 gtts-cli "$LINE" -o $FILENAME.mp3 -l $LANG
 #mpg123 $FILENAME.mp3
done < "voice_list.txt"

for FILEMP3 in *.mp3
do
 echo " process $FILEMP3"
 #need wav microsoft pcm 16 bit mono
 ffmpeg -loglevel warning -y -i $FILEMP3 -filter:a "volume=5" -acodec pcm_s16le -ar 22050 -ac 1 ${FILEMP3%.*}.wav
 rm -f $FILEMP3
done
