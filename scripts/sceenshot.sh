#!/usr/bin/env bash

# ==========================================
# Screenshot Script
# Author : Shykid002
# ==========================================

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILE="$DIR/$(date '+%d-%m-%Y_%H-%M-%S').png"

# Take selected screenshot
if scrot -s "$FILE" 2>/dev/null; then
    dunstify \
        -a "Screenshot" \
        -i "$FILE" \
        -u low \
        "󰹑 Screenshot Saved" \
        "$(basename "$FILE")"

else

    dunstify \
        -a "Screenshot" \
        -u normal \
        " Screenshot Cancelled"

fi

if scrot -s "$FILE"; then

    xclip -selection clipboard -t image/png "$FILE"

    dunstify \
        -a "Screenshot" \
        -i "$FILE" \
        -u low \
        "󰹑 Screenshot Saved" \
        "Copied to clipboard • $(basename "$FILE")"

fi
