#!/bin/bash
VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{ printf("%s", $5) }')
MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{ printf("%s", $2) }')

if [ "$MUTE" = "yes" ]
then
    echo "🔇: $VOL"
else
    echo "🔊: $VOL"
fi
