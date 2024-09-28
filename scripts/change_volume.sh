#!/bin/sh
# Script to change pulseaudio volume using pamixer.
#
# Usage examples:
# ./change_volume mute
# ./change_volume + 5    # Increment 5% volume
# ./change_volume - 1    # Decrement 1% volume

modifier=$1
value=$2

if [ $modifier = "mute" ]; then
    pamixer -t
else
    if [ $modifier = "+" ]; then
        pamixer -i "$value"
    elif [ $modifier = "-" ]; then
        pamixer -d "$value"
    fi
fi

# Gets mute status 
is_muted=$(pamixer --get-mute)

# Gets current volume level
volume=$(pamixer --get-volume)

# Verify if the system is muted or not to choose an icon
if [ $is_muted = "false" ]; then
    if [ $volume = "0" ]; then
        icon="audio-volume-muted"
    elif [ $volume -lt "33" ]; then
        icon="audio-volume-low"
    elif [ $volume -lt "66" ]; then
        icon="audio-volume-medium"
    else
        icon="audio-volume-high"
    fi
else
    icon="audio-volume-muted"
fi

# Throws notification
dunstify -r 999 -t 1200 "Volume" -h int:value:$volume -i $icon
