#!/usr/bin/env bash

set -euo pipefail

CURRENT="$HOME/.cache/current_wallpaper"

[[ -f "$CURRENT" ]] || exit 0

WALLPAPER="$(<"$CURRENT")"

[[ -f "$WALLPAPER" ]] || exit 0

# Restore wallpaper
xwallpaper --stretch "$WALLPAPER"

# Restore previous Pywal theme
command -v wal >/dev/null && wal -R

# Reload Xresources
[[ -f "$HOME/.cache/wal/colors.Xresources" ]] &&
xrdb -merge "$HOME/.cache/wal/colors.Xresources"
