#!/bin/bash

# Verifica si hay una interfaz Ethernet activa
eno1_status=$(cat /sys/class/net/eth0/carrier 2>/dev/null)
# Verifica si hay una interfaz Wi-Fi activa
wlo1_status=$(cat /sys/class/net/wlan0/carrier 2>/dev/null)

if [ "$eno1_status" == "1" ]; then
    echo "%{F#F0C674}eth0%{F-} Connected"
elif [ "$wlo1_status" == "1" ]; then
    echo "%{F#F0C674}wlan0%{F-} Connected"
else
    echo "No network"
fi