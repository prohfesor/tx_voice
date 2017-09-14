#!/bin/bash
LANG=en
PLAY_SOUND=false
LOWERCASE=false
TRUNCATE_LONG=true

while read LINE; do
 FILENAME=${LINE//[^a-zA-Z0-9]/_}
 if $LOWERCASE ; then
  FILENAME="${FILENAME,,}"
 fi
 echo "$LINE -> $FILENAME"
 gtts-cli "$LINE" -o $FILENAME.mp3 -l $LANG
 if $PLAY_SOUND ; then
  mpg123 $FILENAME.mp3
 fi
done < "voice_list.txt"

for FILEMP3 in *.mp3
do
 echo " process $FILEMP3"
 #need wav microsoft pcm 16 bit mono
 ffmpeg -loglevel warning -y -i $FILEMP3 -filter:a "volume=5" -acodec pcm_s16le -ar 22050 -ac 1 ${FILEMP3%.*}.wav
 rm -f $FILEMP3
done

for FILEWAV in *.wav
do
 if [ ${#FILEWAV} -gt 12 ] && $TRUNCATE_LONG ; then
  echo "$FILEWAV - too long, trying to remove underscores"
  FILESHORTER=${FILEWAV//_/}
  if [ ${#FILESHORTER} -gt 12 ] ; then
   echo " $FILESHORTER - still too long, will truncate"
   FILESHORTEST="${FILESHORTER:0:8}.wav"
   echo "  $FILESHORTEST"
   mv $FILEWAV $FILESHORTEST
  else
   mv $FILEWAV $FILESHORTER
   echo "  $FILESHORTER"
  fi
 fi
done
