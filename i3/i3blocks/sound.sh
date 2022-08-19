#!/bin/bash
if [ "$(pamixer --get-mute)" = "true" ]; then
    LABEL="muted"
else
    LABEL="VOL"
fi

echo "$LABEL $(pamixer --get-volume)%"
