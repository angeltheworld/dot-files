#!/bin/sh
# Script used to take different types of screenshots in sway. Three modes are
# available.
# - free: Freeform screenshot
# - focused: Take a screenshot of the focused window
# - worspace: Take a screenshot of the focused workspace (useful for multiple
#             monitor setups)

# Create a file path
directory=~/Pictures/Screenshots
name_format=screenshot_$(date +'%F_%H-%M-%S').png
file_path=$directory/$name_format

# Choose mode
if [ $1 = "free" ]; then
    slurp | grim -l 4 -g - - | tee -a $file_path | wl-copy
else
    if [ $1 = "focused" ]; then
        type=get_tree
    elif [ $1 = "workspace" ]; then
        type=get_workspaces
    fi
    swaymsg -t $type | \
        jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | \
        grim -l 4 -g - - | tee -a $file_path | wl-copy
fi

# Throw notification only if a screenshot was captured.
# This must be handled specially for the "free" case, in which a screenshot 
# can be aborted.
if [ ! -s "$file_path" ]; then
    rm $file_path
else
    dunstify -r 996 -t 1200 "Screenshot" -i $file_path
fi
