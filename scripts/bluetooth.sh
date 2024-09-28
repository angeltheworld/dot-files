#!/bin/sh
# Toggle bluetooth and throw notification

bluetooth toggle
bluetooth_status=$(bluetooth | grep -oP "(on|off)")

# Determines which icon to use
if [ $bluetooth_status = "on" ]; then
    icon="bluetooth-active"
elif [ $bluetooth_status = "off" ]; then
    icon="bluetooth-disabled"
fi

# Throws notification
dunstify -r 997 -t 1200 "Bluetooth" -i $icon
