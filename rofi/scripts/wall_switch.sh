#!/bin/bash

WALL_DIR="$HOME/.config/wallpapers"
CACHE_DIR="$HOME/.cache/wallpaper_thumbs"

ROFI_THEME="$HOME/.config/rofi/themes/walls.rasi"

mkdir -p "$CACHE_DIR"

for img in "$WALL_DIR"/*.{jpg,jpeg,png,webp}; do
    [ -f "$img" ] || continue
    filename=$(basename "$img")
    thumb="$CACHE_DIR/${filename}.png"

    if [ ! -f "$thumb" ]; then
        magick "$img" -resize 240x360^ -gravity center -extent 240x360 "$thumb"
    fi
done

rofi_input=""
for img in "$WALL_DIR"/*.{jpg,jpeg,png,webp}; do
    [ -f "$img" ] || continue
    filename=$(basename "$img")
    thumb="$CACHE_DIR/${filename}.png"
    rofi_input+="${filename}\x00icon\x1f${thumb}\n"
done

SELECTED=$(echo -e "$rofi_input" | rofi -dmenu -theme "$ROFI_THEME")

if [ -n "$SELECTED" ]; then
    FULL_PATH="$WALL_DIR/$SELECTED"
    
    awww img "$FULL_PATH" \
        --transition-type random \
        --transition-pos 0.85,0.97 \
        --transition-step 90 \
        --transition-fps 60

    matugen image "$FULL_PATH" -m dark --source-color-index 0
fi
