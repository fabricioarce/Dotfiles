#!/bin/bash
BATTERY_INFO=$(upower -i $(upower -e | grep battery))
BATTERY_PERCENT=$(echo "$BATTERY_INFO" | grep percentage | awk '{print $2}')
BATTERY_STATUS=$(echo "$BATTERY_INFO" | grep state | awk '{print $2}')

if [[ "$BATTERY_STATUS" == "charging" ]]; then
    echo "󰂄 $BATTERY_PERCENT"
else
    echo "󰁹 $BATTERY_PERCENT"
fi
