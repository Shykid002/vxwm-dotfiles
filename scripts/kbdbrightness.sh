#!/bin/sh

DEVICE="/sys/class/leds/smc::kbd_backlight"

CURRENT=$(cat "$DEVICE/brightness")
MAX=$(cat "$DEVICE/max_brightness")

case "$1" in
    +)
        NEW=$((CURRENT + 1))
        [ "$NEW" -gt "$MAX" ] && NEW=$MAX
        ;;
    -)
        NEW=$((CURRENT - 1))
        [ "$NEW" -lt 0 ] && NEW=0
        ;;
    *)
        exit 1
        ;;
esac

echo "$NEW" > "$DEVICE/brightness"
