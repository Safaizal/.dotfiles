#!/bin/bash
# Generate hyprlock.conf dynamically based on monitor resolution
# This ensures the lock screen looks good on any screen size

OUTPUT="${HOME}/.config/hypr/hyprlock.conf"

# Get monitor resolution (use first connected monitor)
RES=$(hyprctl monitors -j 2>/dev/null | jq -r '.[0] | "\(.width) \(.height)"' 2>/dev/null)
if [ -z "$RES" ]; then
    RES="1920 1080"
fi
W=$(echo "$RES" | cut -d' ' -f1)
H=$(echo "$RES" | cut -d' ' -f2)

# All math done via awk (no bc dependency)
calc() { awk "BEGIN { printf \"%d\", $1 }"; }

# Reference screen: 1920x1080
# Percent of screen height for a pixel value on 1080p
# e.g. 250px on 1080p = 250/1080*100 = 23.1% of height
# Then convert that % back to pixels for the current screen: %/100 * H

INPUT_W=$(calc "23.1 * $H / 100")      # 250px on 1080p
INPUT_H=$(calc "5.6 * $H / 100")       # 60px on 1080p
USER_BOX_W=$(calc "23.1 * $H / 100")
USER_BOX_H=$(calc "5.6 * $H / 100")
AVATAR_SIZE=$(calc "11.1 * $H / 100")  # 120px on 1080p
BATT_BG_W=$(calc "7.4 * $H / 100")
BATT_BG_H=$(calc "3.0 * $H / 100")

# Positions as % of screen height, then converted to pixels
# Original values on 1080p → percentage of height → pixels on current screen
TIME_HH_YTOP=$(calc "23.1 * $H / 100")    # -250 from top
TIME_MM_YTOP=$(calc "38.9 * $H / 100")    # -420 from top
INPUT_YCTR=$(calc "43.5 * $H / 100")       # -470 from center
DATE_YCTR=$(calc "12.0 * $H / 100")        # -130 from center
USERBOX_YCTR=$(calc "37.0 * $H / 100")     # -400 from center
USERLBL_YCTR=$(calc "37.0 * $H / 100")     # -400 from center
AVATAR_YCTR=$(calc "26.9 * $H / 100")      # -290 from center
CORNER_Y=$(calc "1.7 * $H / 100")          # -20 from top (weather/battery)
CORNER_X=$(calc "3.7 * $H / 100")          # 40/30 from edge

# Font sizes scaled to screen height (reference: 150px on 1080p → 13.9%)
TIME_FSIZE=$(calc "13.9 * $H / 100")
DATE_FSIZE=$(calc "1.3 * $H / 100")        # 14px on 1080p
USER_FSIZE=$(calc "1.9 * $H / 100")        # 20px on 1080p
INFO_FSIZE=$(calc "1.3 * $H / 100")        # 14px on 1080p

FNAME="JetBrainsMono Nerd Font Mono"
FNAME_B="JetBrains Mono Nerd Font Mono ExtraBold"

cat > "$OUTPUT" <<EOF
\$Weather = ~/.config/hypr/hyprlock/scripts/weather.sh

background {
    monitor =
    path = screenshot
    blur_passes = 2
    blur_size = 7
    brightness = 0.8
}

# INPUT FIELD
input-field {
    monitor =
    size = ${INPUT_W}, ${INPUT_H}
    outline_thickness = 0
    outer_color = rgb(255, 255, 255)
    dots_size = 0.3
    dots_spacing = 1
    dots_center = true
    inner_color = rgb(0, 0, 0)
    font_family = ${FNAME} ExtraBold
    font_color = rgb(0, 255, 0)
    fade_on_empty = true
    placeholder_text = PASS >_<
    hide_input = false
    position = 0, -${INPUT_YCTR}
    halign = center
    valign = center
    zindex = 20
}

# TIME HH
label {
    monitor =
    text = cmd[update:1000] echo -e "\$(date +"%H")"
    color = rgba(255, 255, 255, 1)
    shadow_size = 3
    shadow_color = rgb(0,0,0)
    shadow_boost = 1.2
    font_size = ${TIME_FSIZE}
    font_family = ${FNAME}
    position = 0, -${TIME_HH_YTOP}
    halign = center
    valign = top
    zindex = 5
}

# TIME MM
label {
    monitor =
    text = cmd[update:1000] echo -e "\$(date +"%M")"
    color = rgba(255, 255, 255, 1)
    font_size = ${TIME_FSIZE}
    font_family = ${FNAME}
    position = 0, -${TIME_MM_YTOP}
    halign = center
    valign = top
    zindex = 5
}

# DATE
label {
    monitor =
    text = cmd[update:1000] echo -e "\$(date +"%d %b %A")"
    color = rgba(255, 255, 255, 1)
    font_size = ${DATE_FSIZE}
    font_family = ${FNAME_B}
    position = 0, -${DATE_YCTR}
    halign = center
    valign = center
    zindex = 5
}

# USER-BOX
shape {
    monitor =
    size = ${USER_BOX_W}, ${USER_BOX_H}
    color = rgba(255, 255, 255, 0.1)
    rounding = -1
    border_size = 0
    border_color = rgba(255, 255, 255, 1)
    rotate = 0
    xray = false
    position = 0, -${USERBOX_YCTR}
    halign = center
    valign = center
}

# USER
label {
    monitor =
    text =  \$USER
    color = rgb(255, 255, 255)
    outline_thickness = 0
    dots_size = 0.2
    dots_spacing = 0.2
    dots_center = true
    font_size = ${USER_FSIZE}
    font_family = ${FNAME} Bold
    position = 0, -${USERLBL_YCTR}
    halign = center
    valign = center
}

# WEATHER
label {
    monitor =
    text = cmd[update:1000] \$Weather
    color = rgb(255, 255, 255)
    font_size = ${INFO_FSIZE}
    font_family = ${FNAME_B}
    position = ${CORNER_X}, -${CORNER_Y}
    halign = left
    valign = top
    zindex = 5
}

# Battery bg
shape {
    monitor =
    size = ${BATT_BG_W}, ${BATT_BG_H}
    color = rgba(0, 0, 0, 0.5)
    rounding = 20
    rotate = 0
    position = -${CORNER_X}, -${CORNER_Y}
    halign = right
    valign = top
    zindex = 1
}

# Battery
label {
    monitor =
    text = cmd[update:30000] echo "󰁹 \$(cat /sys/class/power_supply/BAT0/capacity)%"
    color = rgb(255, 255, 255)
    font_size = ${INFO_FSIZE}
    font_family = ${FNAME_B}
    position = -${CORNER_X}, -${CORNER_Y}
    halign = right
    valign = top
    zindex = 5
}

# Avatar
image {
    monitor =
    path = ~/.face/araragi.jpg
    size = ${AVATAR_SIZE}
    rounding = -1
    border_size = 4
    border_color = rgb(221, 221, 221)
    rotate = 0
    reload_time = -1
    position = 0, -${AVATAR_YCTR}
    halign = center
    valign = center
}
EOF

echo "Generated hyprlock.conf for ${W}x${H} screen"
