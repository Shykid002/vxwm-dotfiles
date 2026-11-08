#!/usr/bin/env bash

set -euo pipefail

CURRENT="$HOME/.cache/current_wallpaper"

[[ -f "$CURRENT" ]] || exit 0

WALLPAPER="$(<"$CURRENT")"

[[ -f "$WALLPAPER" ]] || exit 0

# Restore wallpaper
xwallpaper --stretch "$WALLPAPER"

# Restore previous Pywal theme
if command -v wal >/dev/null 2>&1; then
    wal -R
fi

# Reload Xresources
if [[ -f "$HOME/.cache/wal/colors.Xresources" ]]; then
    xrdb -merge "$HOME/.cache/wal/colors.Xresources"
fi

# Give Pywal/Xresources a moment to settle
sleep 0.2

# Reload VXWM
if command -v xdotool >/dev/null 2>&1; then
    xdotool key --clearmodifiers Super+F5
fi
