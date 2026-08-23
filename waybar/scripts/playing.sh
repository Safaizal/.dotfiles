#!/bin/bash

zscroll -l 20 \
    --delay 0.3 \
    --update-check true \
    --scroll-padding " 󰽴 " \
    "playerctl metadata --format '{{ title }} - {{ artist }}'" 2>/dev/null 

wait
