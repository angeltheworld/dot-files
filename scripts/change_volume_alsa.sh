#!/bin/sh
# Using pamixer to control sound

modifier=$1
increment=$2

if [ $modifier = "mute" ]; then
    amixer set Master toggle > /dev/null
else
    if [ $modifier = "+" ]; then
        amixer set Master "$increment"+ > /dev/null
    elif [ $modifier = "-" ]; then
        amixer set Master "$increment"- > /dev/null
    fi
fi

# Gets mute status 
audio_status=$(amixer get Master | grep -oP '\[\K[^\]]+(?=\]\s*$)')

# Gets current volume level
volume=$(amixer get Master -R | tail -1 | grep -oE '\b[0-9]{1,3}%' | grep -oE '\b[0-9]{1,3}')

# Verify if the system is muted or not to choose an icon
if [ $audio_status = "on" ]; then
    if [ $volume = "0" ]; then
        icon="audio-volume-muted"
    elif [ $volume -lt "33" ]; then
        icon="audio-volume-low"
    elif [ $volume -lt "66" ]; then
        icon="audio-volume-medium"
    else
        icon="audio-volume-high"
    fi
elif [ $audio_status = "off" ]; then
    icon="audio-volume-muted"
fi

# Throws notification
dunstify -r 999 -t 1200 "Volume" -h int:value:$volume -i $icon
