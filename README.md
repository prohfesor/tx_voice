# TX Voice
Generate voice files for ersky9x transmitter from text file

This is simple bash script that will generate voice files for your RC transmitter from text file.
Script uses google text-to-speech engine to generate voice, and ffmpeg for conversion to correct wav format.

## Requirements
Install google text-to-speech library via python pip:
```
pip install gTTS
```
(You will need pip manager installed. If you don't have it, find it here: https://pip.pypa.io/en/stable/installing/)

Install `ffmpeg` via any way suitable for your operation system.

Ensure you have bash enterpreter.

## Using
* Edit voice messages in `voice_list.txt`.
* Run `voice.sh`.
* Copy resulting .wav files from your folder to corresponding folders of your transmitter SD card.
