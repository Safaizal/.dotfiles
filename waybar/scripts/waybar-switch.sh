#!/bin/bash
# ~/.config/waybar/scripts/waybar-switch.sh

LAYOUT=$1
WAYBAR_DIR="$HOME/.config/waybar"

case $LAYOUT in
    full)
        CONFIG="$WAYBAR_DIR/layouts/config-full.jsonc"
        STYLE="$WAYBAR_DIR/styles/style-full.css"
        ;;
    minimal)
        CONFIG="$WAYBAR_DIR/layouts/config-minimal.jsonc"
        STYLE="$WAYBAR_DIR/styles/style-minimal.css"
        ;;
      *)
        echo "Usage: $0 {full|minimal}"
        exit 1
        ;;
esac

killall waybar
sleep 0.3
waybar -c "$CONFIG" -s "$STYLE" &
