#!/bin/bash

# i3bar input protocol docs:
# https://i3wm.org/docs/i3bar-protocol.html

volume() {
  VOL=$(pamixer --get-volume)
  if [ $(pamixer --get-mute) = "true" ]; then
    MUTE_STATUS=" (muted)"
  else
    MUTE_STATUS=""
  fi
  echo "
    {
      \"name\": \"volume\",
      \"full_text\": \"volume: $VOL%$MUTE_STATUS\",
      \"separator\": false,
      \"separator_block_width\": 16,
      \"color\": \"#ffffff\"
    }
  "
}

mic() {
  MIC=$(pamixer --default-source --get-volume)
  if [ $(pamixer --default-source --get-mute) = "true" ]; then
    MIC_MUTE_STATUS=" (muted)"
  else
    MIC_MUTE_STATUS=""
  fi
  echo "
    {
      \"name\": \"microphone\",
      \"full_text\": \"mic: $MIC%$MIC_MUTE_STATUS\",
      \"separator\": false,
      \"separator_block_width\": 16,
      \"color\": \"#ffffff\"
    }
  "
}

battery() {
  if [ -d /sys/class/power_supply/BAT0 ]; then
    if [ -f /sys/class/power_supply/BAT0/capacity ]; then
      REMAIN=$(cat /sys/class/power_supply/BAT0/capacity)
    fi
    if [ -f /sys/class/power_supply/BAT0/status ]; then
      CHARGE_STATUS=$(cat /sys/class/power_supply/BAT0/status)
    fi
  fi

  if [ $CHARGE_STATUS = "Charging" ]; then
    BAT_COLOR="#d0d000"
  elif [ $REMAIN -le 15 ]; then
    BAT_COLOR="#fa1e44"
  else
    BAT_COLOR="#ffffff"
  fi

  echo "
    {
      \"name\": \"battery\",
      \"full_text\": \"battery: $REMAIN% ($CHARGE_STATUS)\",
      \"separator\": false,
      \"separator_block_width\": 16,
      \"color\": \"$BAT_COLOR\"
    }
  "
}

datetime() {
  echo "
    {
      \"name\": \"datetime\",
      \"full_text\": \"$(date '+%Y-%m-%d %H:%M')\",
      \"separator\": false,
      \"separator_block_width\": 16,
      \"color\": \"#ffffff\"
    }
  "
}

# header
echo '{ "version": 1 }'

# infinit array
echo '['

while true; do
  echo "[$(volume),$(mic),$(battery),$(datetime)],"
  sleep 3
done
