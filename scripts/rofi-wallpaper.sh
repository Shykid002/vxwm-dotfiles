#!/usr/bin/env bash

set -euo pipefail

# ----------------------------------------------------------------------------- # Configuration # -----------------------------------------------------------------------------

WALL_DIR="$HOME/Pictures/Wallpapers"
CACHE_DIR="$HOME/.cache"
CURRENT_WALL="$CACHE_DIR/current_wallpaper"

ROFI_THEME="$HOME/.config/rofi/wall-changer.rasi"
DUNST_SCRIPT="$HOME/scripts/wal-dunst.sh"

mkdir -p "$WALL_DIR" "$CACHE_DIR"

# ----------------------------------------------------------------------------- # Build wallpaper list for Rofi # -----------------------------------------------------------------------------

mapfile -d '' -t FILES < <(
    find "$WALL_DIR" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) \
    -print0 | sort -z
)

ROFI_INPUT=""
SELECTED_ROW=0

LAST=""
[[ -f "$CURRENT_WALL" ]] && LAST="$(cat "$CURRENT_WALL")"

for i in "${!FILES[@]}"; do
    file="${FILES[$i]}"
    name="$(basename "$file")"

    ROFI_INPUT+="${name}\0icon\x1f${file}\n"

    if [[ "$file" == "$LAST" ]]; then
        SELECTED_ROW=$i
    fi
done

SELECTION=$(
    echo -e "$ROFI_INPUT" |
    rofi \
        -show-icons \
        -theme "$ROFI_THEME" \
        -selected-row "$SELECTED_ROW" \
        -dmenu \
        -i \
        -p "Wallpaper" \
        -kb-row-up "Up,Control+p,ScrollUp" \
        -kb-row-down "Down,Control+n,ScrollDown" \
        -me-select-entry '' \
        -me-accept-entry MousePrimary
)

[[ -z "$SELECTION" ]] && exit 0

WALLPAPER="$WALL_DIR/$SELECTION"

[[ ! -f "$WALLPAPER" ]] && {
    notify-send "Wallpaper" "Selected wallpaper does not exist."
    exit 1
}
# ----------------------------------------------------------------------------- # Save wallpaper for restoration after reboot # -----------------------------------------------------------------------------

echo "$WALLPAPER" > "$CURRENT_WALL"

# ----------------------------------------------------------------------------- # Apply Wallpaper # -----------------------------------------------------------------------------

xwallpaper --stretch "$WALLPAPER"

# ----------------------------------------------------------------------------- # Pywal # -----------------------------------------------------------------------------

command -v wal >/dev/null && wal -i "$WALLPAPER" -n

# ----------------------------------------------------------------------------- # Reload Xresources # -----------------------------------------------------------------------------

[[ -f "$HOME/.cache/wal/colors.Xresources" ]] && xrdb -merge "$HOME/.cache/wal/colors.Xresources"

# ----------------------------------------------------------------------------- # Reload vxwm colors # -----------------------------------------------------------------------------

command -v xdotool >/dev/null && xdotool key Super+F5

# ----------------------------------------------------------------------------- # Update Dunst # -----------------------------------------------------------------------------

[[ -x "$DUNST_SCRIPT" ]] && "$DUNST_SCRIPT"

# ----------------------------------------------------------------------------- # Restart cava # -----------------------------------------------------------------------------

killall -USR2 cava 2>/dev/null || true

# ----------------------------------------------------------------------------- # Update Betterlockscreen # -----------------------------------------------------------------------------

command -v betterlockscreen >/dev/null && betterlockscreen -u "$WALLPAPER"

# ----------------------------------------------------------------------------- # Notification # -----------------------------------------------------------------------------

notify-send "    Wallpaper Updated"

notify-send "  Pywal theme applied successfully."
