#!/bin/bash

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9].*\)%* id.*/\1/" | awk '{print 100 - $1}')

WIFI_SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
[ -z "$WIFI_SSID" ] && WIFI_SSID="Disconnected"

if bluetoothctl show | grep -q "Powered: yes"; then
	BT_STATUS="On"
else
	BT_STATUS="Off"
fi

TEMP=$(cat /sys/class/thermal/thermal_zone2/temp 2>/dev/null)

# 2. Convert millidegrees to Celsius (e.g., 45000 to 45)
if [ -n "$TEMP" ]; then
    TEMP_C=$((TEMP / 1000))
else
    TEMP_C="N/A"
fi

if [ "$TEMP_C" -ge 80 ]; then
    ICON="" # Hot icon
else
    ICON="" # Normal icon
fi


OPTION_CPU="󰻠 CPU Utilization: ${CPU_USAGE}%"
OPTION_WIFI="󰤨 Wi-Fi: ${WIFI_SSID}"
OPTION_BT=" Blutooth: ${BT_STATUS}"
OPTION_TEMP="System_Temp: ${TEMP_C}°C ${ICON}"

CHOSEN=$(echo -e "${OPTION_WIFI}\n${OPTION_BT}\n${OPTION_CPU}\n${OPTION_TEMP}" | rofi -dmenu -i -p "Quick Settings" -theme-str 'window {width: 420px;location: northeast; anchor: northeast; x-offset: -20px; y-offset: 20px;}')

case "$CHOSEN" in
	*"Wi-Fi"*)
		kitty --class floating_control -e nmtui
		;;
	
	*"Blutooth"*)
		blueman-manger || kitty --class floating_control -e bluetoothctl
		;;
	
	*"CPU"*)
		kitty --class floating_control -e btop
		;;
	*"System_Temp"*)
		;;
esac
