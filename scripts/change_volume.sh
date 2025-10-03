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
    message="Volume"
else
    message="Volume [muted]"
fi

# Throws notification
dunstify -r 999 -t 1200 $message -h int:value:$volume
