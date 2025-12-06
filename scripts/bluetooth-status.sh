#!/bin/bash

if ! bluetoothctl show | grep -q "Powered: yes"; then
	echo '{"text": "󰂲", "class": "off", "tooltip": "Bluetooth Off"}'
	exit 0
fi

devices=$(bluetoothctl devices Connected | cut -d ' ' -f 3-)

if [ -z "$devices" ]; then
    echo '{"text": "󰂯", "class": "on", "tooltip": "Bluetooth On"}'
else
    tooltip=$(echo "$devices" | sed 's/$/\\n/' | tr -d '\n')
    echo '{"text": "󰂱", "class": "connected", "tooltip": "$tooltip"}'
fi
