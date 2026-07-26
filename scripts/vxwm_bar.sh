#!/usr/bin/env bash

# ==========================================
# VXWM Status Bar
# Updates the root window name for VXWM
# ==========================================

get_battery() {

    # Detect battery
    if [[ -d /sys/class/power_supply/BAT0 ]]; then
        BAT="BAT0"
    elif [[ -d /sys/class/power_supply/BAT1 ]]; then
        BAT="BAT1"
    else
        echo "󰂃 No Battery"
        return
    fi

    status=$(<"/sys/class/power_supply/$BAT/status")

    # Calculate battery percentage ourselves
    # (More accurate than /capacity on many MacBooks)
    if [[ -f /sys/class/power_supply/$BAT/charge_now ]]; then

        charge_now=$(<"/sys/class/power_supply/$BAT/charge_now")
        charge_full=$(<"/sys/class/power_supply/$BAT/charge_full")

        percent=$(( (charge_now * 100 + charge_full / 2) / charge_full ))

    elif [[ -f /sys/class/power_supply/$BAT/energy_now ]]; then

        energy_now=$(<"/sys/class/power_supply/$BAT/energy_now")
        energy_full=$(<"/sys/class/power_supply/$BAT/energy_full")

        percent=$(( (energy_now * 100 + energy_full / 2) / energy_full ))

    else

        percent=$(<"/sys/class/power_supply/$BAT/capacity")

    fi

    # Clamp percentage
    (( percent > 100 )) && percent=100
    (( percent < 0 )) && percent=0

    # Icons
    case "$status" in
        Charging)
            printf "⚡ %d%%" "$percent"
            ;;
        Full)
            printf "🔌 %d%%" "$percent"
            ;;
        *)
            printf "🔋 %d%%" "$percent"
            ;;
    esac
}

# ==========================================
# CPU Temperature
# ==========================================


get_temp() {

    temp=$(sensors | awk '
        /Package id 0:/ {
            gsub(/\+|°C/,"",$4)
            print int($4)
            exit
        }')

    if [[ -n "$temp" ]]; then
        printf " %s°C" "$temp"
    else
        printf " N/A"
    fi
}


# ==========================================
# Main Loop
# ==========================================

while true; do

    BATTERY="$(get_battery)"
    MEM="$(free -h | awk '/Mem:/ {sub(/i/, "", $3); print $3}')"
    DATE="$(date '+%a %d %b')"
    TIME="$(date '+%H:%M')"
    TEMP="$(get_temp)"

    xsetroot -name " ${BATTERY}| 󰍛 ${MEM} | ${TEMP} | ${DATE} | ${TIME} "

    sleep 10

done
