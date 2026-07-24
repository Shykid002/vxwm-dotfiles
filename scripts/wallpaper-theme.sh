#!/usr/bin/env bash

set -euo pipefail

# ==========================
# Configuration
# ==========================

WALL_DIR="$HOME/Pictures/Wallpapers"
ROFI_THEME="$HOME/.config/rofi/wall-changer.rasi"

mkdir -p "$WALL_DIR"

# ==========================
# Build Rofi Menu
# ==========================

ROFI_INPUT=""

while IFS= read -r -d '' file; do
    filename=$(basename "$file")
    ROFI_INPUT+="${filename}\0icon\x1f${file}\n"
done < <(
    find "$WALL_DIR" -maxdepth 1 -type f \
    \( -iname "*.jpg" \
    -o -iname "*.jpeg" \
    -o -iname "*.png" \
    -o -iname "*.webp" \) \
    -print0 | sort -z
)

SELECTION=$(printf "%b" "$ROFI_INPUT" | \
    rofi \
    -show-icons \
    -theme "$ROFI_THEME" \
    -dmenu \
    -i \
    -p "󰸉 Wallpaper")

[ -z "$SELECTION" ] && exit 0

WALLPAPER="$WALL_DIR/$SELECTION"

# ==========================
# Wallpaper
# ==========================

xwallpaper --stretch "$WALLPAPER"

# ==========================
# Generate Pywal Theme
# ==========================

wal -i "$WALLPAPER" -n

xrdb -merge "$HOME/.cache/wal/colors.Xresources"

# ==========================
# Reload VXWM
# ==========================

xdotool key Super+F5

# ==========================
# Reload Kitty
# ==========================

if command -v kitty >/dev/null; then

    if [ -f "$HOME/.cache/wal/colors-kitty.conf" ]; then
        kitty @ set-colors --all "$HOME/.cache/wal/colors-kitty.conf" >/dev/null 2>&1 || true

    elif [ -f "$HOME/.cache/wal/kitty.conf" ]; then
        kitty @ set-colors --all "$HOME/.cache/wal/kitty.conf" >/dev/null 2>&1 || true
    fi
fi

# ==========================
# Reload Dunst
# ==========================

if command -v dunstctl >/dev/null; then
    dunstctl reload >/dev/null 2>&1 || true
elif [ -f "$HOME/wal-dunst.sh" ]; then
    "$HOME/wal-dunst.sh"
fi

# ==========================
# Reload GTK Theme
# (optional)
# ==========================

if command -v pywalfox >/dev/null; then
    pywalfox update >/dev/null 2>&1 || true
fi

# ==========================
# Notification
# ==========================

notify-send \
    "󰸉 Wallpaper Changed" \
    "$(basename "$WALLPAPER")\nPywal theme synchronized."
