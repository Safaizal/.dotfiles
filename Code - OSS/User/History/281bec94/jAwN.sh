#!/usr/bin/env bash

# Use -theme option to target a specific minimal style
chosen=$(printf "\n\n" | rofi -dmenu -i -p "Power" -theme ~/.config/rofi/power-strip.rasi)

case "$chosen" in
    "") systemctl poweroff ;;
    "") systemctl suspend ;;
    "") hyprlock ;;
    "R") systemctl reboot ;;
esac
