#!/bin/bash

# Load Pywal colors
source "$HOME/.cache/wal/colors.sh"

betterlockscreen -l dimblur -- \
    --ring-color "${color4}ff" \
    --inside-color "${background}88" \
    --keyhl-color "${color2}ff" \
    --bshl-color "${color1}ff" \
    --separator-color "${foreground}ff" \
    --line-color "${color5}ff" \
    --time-color "${foreground}ff" \
    --date-color "${foreground}ff"
