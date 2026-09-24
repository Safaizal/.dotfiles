WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# 3. Pick a random image and apply it
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
echo "Setting wallpaper to: $RANDOM_WALLPAPER"
awww img "$RANDOM_WALLPAPER" --transition-type grow

matugen image "$RANDOM_WALLPAPER" -m dark --source-color-index 0

