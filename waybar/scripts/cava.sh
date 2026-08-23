#!/bin/bash

config_file="/tmp/waybar_cava_config"
cat > "$config_file" <<EOF
[general]
framerate = 60
bars = 12

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

# 2. Run Cava and translate the output instantly using sed
# To change the style, just swap the characters inside this sed command!
cava -p "$config_file" | sed -u 's/;//g; s/0/⡀/g; s/1/⡀/g; s/2/⡄/g; s/3/⡆/g; s/4/⡇/g; s/5/⣇/g; s/6/⣧/g; s/7/⣷/g; s/8/⣿/g;'
