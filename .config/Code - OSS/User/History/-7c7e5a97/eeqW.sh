#!/bin/bash

# Verifica si hay una interfaz Ethernet activa
eth_status=$(cat /sys/class/net/eth0/carrier 2>/dev/null)
# Verifica si hay una interfaz Wi-Fi activa
wlan_status=$(cat /sys/class/net/wlan0/carrier 2>/dev/null)

if [ "$eth_status" == "1" ]; then
    echo "%{F#F0C674}eth0%{F-} Connected"
elif [ "$wlan_status" == "1" ]; then
    echo "%{F#F0C674}wlan0%{F-} Connected"
else
    echo "No network"
fi