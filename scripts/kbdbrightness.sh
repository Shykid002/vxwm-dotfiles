#!/bin/sh
# Convert dwm arguments (+ / -) into brightnessctl steps (e.g., 10%+ or 10%-)
if [ "$1" == "+" ]; then
    STEP="10%+"
elif [ "$1" == "-" ]; then
    STEP="10%-"
else
    STEP="$1"
fi

# Adjust keyboard brightness
brightnessctl --device="smc::kbd_backlight" set "$STEP"

# Get current keyboard brightness percentage safely
BRIGHT=$(brightnessctl --device="smc::kbd_backlight" i | grep -oP '\(\K[0-9]+(?=%\))')

# Send notification with progress bar and static ID (-r 9994)
dunstify -r 9994 -a "KbdBrightness" "Keyboard Brightness: ${BRIGHT}%" -h int:value:"$BRIGHT" -h string:x-dunst-stack-tag:kbdbrightness


