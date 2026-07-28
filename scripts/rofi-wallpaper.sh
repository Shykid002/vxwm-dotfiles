#!/bin/bash

# Target directory containing your wallpapers
WALL_DIR="$HOME/Pictures/Wallpapers"

# Ensure the wallpaper directory exists, create it if it doesn't
mkdir -p "$WALL_DIR"

# Kill any existing GIF wallpaper loop before applying a new wallpaper
killall xwinwrap 2>/dev/null
killall gifview 2>/dev/null

# Generate the input list for Rofi with explicit icon paths (\0icon\x1f)
# ADDED: Include .gif files in the grep match regex pattern
ROFI_INPUT=""
while read -r file; do
    if [ -n "$file" ]; then
        ROFI_INPUT+="${file}\0icon\x1f${WALL_DIR}/${file}\n"
    fi
done <<< "$(ls -1 "$WALL_DIR" | grep -E "\.(jpg|jpeg|png|gif)$")"

# Launch Rofi with icon support and pipe the formatted input
SELECTION=$(echo -e "$ROFI_INPUT" | rofi -show-icons -theme ~/.config/rofi/wall-changer.rasi -dmenu -i -p "   Wallpaper")

# If the user does not select anything (e.g., presses ESC), exit the script safely
if [ -z "$SELECTION" ]; then
    exit 1
fi

# Construct the absolute full path to the selected wallpaper file
WALLPAPER="$WALL_DIR/$SELECTION"

# Get screen dimensions for xwinwrap (Dynamic fallback to 1920x1080 if xrandr fails)
SCREEN_RES=$(xrandr | grep '*' | awk '{print $1}' | head -n1)
SCREEN_RES=${SCREEN_RES:-"1920x1080"}

# ADDED: Conditional engine logic depending on whether a GIF or image file is picked
if [[ "$WALLPAPER" =~ \.gif$ ]]; then
    # Run the animated loop in the background layer
    xwinwrap -g "$SCREEN_RES" -ov -ni -s -nf -- gifview -w WID "$WALLPAPER" -a &
else
    # 1. Set the desktop background using xwallpaper with the stretch option
    xwallpaper --stretch "$WALLPAPER"
fi

# 2. Run pywal to generate a new color palette based on the wallpaper
wal -i "$WALLPAPER" -n

# Reload the Xresources db so xrdb patch inside vxwm can see the new colors
xrdb -merge "$HOME/.cache/wal/colors.Xresources"

# Send an X key event to simulate pressing Mod+F5 to live-reload vxwm colors
xdotool key Super+F5

# 3. Trigger the Dunst color synchronizer script to apply the new theme
if [ -f "$HOME/scripts/wal-dunst.sh" ]; then
    "$HOME/scripts/wal-dunst.sh"
fi

# 4. Restart cava
killall -USR2 cava

# lockscreen wallpaper (Note: betterlockscreen converts GIFs to static cached frames automatically)
betterlockscreen -u "$WALLPAPER"

# Send a desktop notification indicating a successful theme change
notify-send "Wallpaper Updated" "System color theme has been synchronized!"

