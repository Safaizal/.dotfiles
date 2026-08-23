#!/usr/bin/env bash

# Use -theme option to target a specific minimal style
chosen=$(printf "\n\n\nR" | rofi -dmenu -i -p "Power" -theme ~/.config/rofi/themes/powermenu.rasi)

case "$chosen" in
    "") systemctl poweroff ;;
    "") systemctl suspend ;;
    "") hyprlock ;;
    "R") systemctl reboot ;;
esac
