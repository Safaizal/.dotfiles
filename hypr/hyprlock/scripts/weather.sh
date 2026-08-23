#!/bin/bash

# Define a fallback text file to cache the result
CACHE_FILE="$HOME/.cache/.weather_cache"

# Fetch weather condition string from wttr.in (format: "Weather: Clear +25°C")
# Replace "Paris" with your actual city name or leave it blank to auto-detect by IP
WEATHER=$(curl -s "wttr.in/?format=%C+%t" | tr -s ' ')

if [ -n "$WEATHER" ]; then
    echo "$WEATHER" > "$CACHE_FILE"
    echo "$WEATHER"
else
    # If the network fails, use the cached version or fallback text
    if [ -f "$CACHE_FILE" ]; then
        cat "$CACHE_FILE"
    else
        echo "Weather Unavailable"
    fi
fi

