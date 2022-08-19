#!/bin/bash
BAT=$(acpi --battery)

REMAIN=$(echo "$BAT" | grep -E -o '[0-9][0-9]?[0-9]?%')
IS_CHARGING=$(echo "$BAT" | awk '{ printf("%s", substr($3, 0, length($3)-1)) }')

if [ "$IS_CHARGING" = "Charging" ]; then
    echo "Charging $REMAIN"
    echo "BAT: $REMAIN"
    echo "#D0D000"
else
    echo "Discharging $REMAIN"
    echo "BAT: $REMAIN"

    # low battery?
    if [ ${REMAIN%?} -le 15 ]; then
        echo "#FA1E44"
    fi
fi
