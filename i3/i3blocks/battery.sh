#!/bin/bash
BAT=$(acpi --battery)

REMAIN=$(echo "$BAT" | grep -E -o '[0-9][0-9]?%')
IS_CHARGING=$(echo "$BAT" | awk '{ printf("%s", substr($3, 0, length($3)-1 ) ) }')

echo "🔋$REMAIN"
echo "BAT: $REMAIN"

if [ "$IS_CHARGING" = "Charging" ]
then
    echo "#D0D000"
else
    if [ ${REMAIN%?} -le 15 ]
    then
        echo "#FA1E44"
    else
        echo "#007872"
    fi
fi

exit 0
