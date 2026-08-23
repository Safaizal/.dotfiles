#!/usr/bin/env bash

# Use -theme option to target a specific minimal style
chosen=$(printf "\n\n\n󰜉" | rofi -dmenu -i -p "Power" -theme ~/.config/rofi/themes/powermenu.rasi)

case "$chosen" in
    "") systemctl poweroff ;;
    "") systemctl suspend ;;
    "") hyprlock ;;
    "󰜉") systemctl reboot ;;
esac
