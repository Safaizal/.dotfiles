#!/bin/bash
if [ "$1" == "toggle" ]; then
  if pgrep -x waybar > /dev/null; then
    killall waybar
  else
    waybar &
  fi 
else
  if pgrep -x waybar > /dev/null; then
    killall waybar 
    sleep 0.2
  fi
  waybar &
fi 


