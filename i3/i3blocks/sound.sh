#!/bin/bash
if [ "$(pamixer --get-mute)" = "true" ]
then
    ICON="🔇"
else
    ICON="🔊"
fi

echo "$ICON $(pamixer --get-volume)%"
