#!/usr/bin/env bash

source "$HOME/.cache/wal/colors.sh"

betterlockscreen -l blur -- \
    --ring-color "${color4}ff" \
    --inside-color "${background}88" \
    --keyhl-color "${color2}ff" \
    --bshl-color "${color1}ff" \
    --separator-color "${foreground}ff" \
    --line-color "${color5}ff" \
    --time-color "${foreground}ff" \
    --date-color "${foreground}ff" \
    --layout-color "${foreground}ff" \
    --verif-color "${foreground}ff" \
    --wrong-color "${color1}ff" \
    --time-font "JetBrainsMono Nerd Font" \
    --date-font "JetBrainsMono Nerd Font" \
    --layout-font "JetBrainsMono Nerd Font"
  
