#!/bin/bash

# 1. Source the correct Pywal shell script file to load the bash variables
if [ -f "$HOME/.cache/wal/colors.sh" ]; then
    source "$HOME/.cache/wal/colors.sh"
else
    echo "Pywal colors not found. Please run 'wal' first."
    exit 1
fi

# 2. Create the dunst config directly with the correct colors and fonts
mkdir -p "$HOME/.config/dunst"
cat <<EOF > "$HOME/.config/dunst/dunstrc"
[global]
    monitor = 0
    follow = mouse
    width = 300
    height = 200
    origin = top-right
    offset = 10x50
    scale = 0
    notification_limit = 0

    # Updated to your new font!
    font = JetBrainsMono Nerd Font 10
    line_height = 0
    format = "<b>%s</b>\n%b"
    alignment = left
    word_wrap = yes
    stack_duplicates = true

    frame_width = 3
    separator_height = 2
    padding = 8
    horizontal_padding = 8
    separator_color = frame

[urgency_low]
    background = "$background"
    foreground = "$foreground"
    frame_color = "$color8"
    timeout = 10

[urgency_normal]
    background = "$background"
    foreground = "$foreground"
    frame_color = "$color2"
    timeout = 10

[urgency_critical]
    background = "$background"
    foreground = "$foreground"
    frame_color = "$color1"
    timeout = 20
EOF

# 3. Restart Dunst so it instantly applies the configuration
killall dunst 2>/dev/null || true
dunst &

# 4. Send a test notification to verify
notify-send "Pywal Core" "Your notification theme is running perfectly!"

