#!/bin/bash
VOL=$(pamixer --get-volume)
IS_MUTE=$(pamixer --get-mute)

if [ "$IS_MUTE" = "true" ]
then
    echo "🔇: $VOL%"
else
    echo "🔊: $VOL%"
fi
