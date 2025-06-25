#!/usr/bin/env bash

nm-applet --indicator > /dev/null 2>&1 &

eww daemon > /dev/null 2>&1 &

#swww kill > /dev/null 2>&1 ; swww-daemon --format xrgb > /dev/null 2>&1 &

dunst > /dev/null 2>&1 &

playerctld daemon ; spotify_player -d

#swww img "/home/hrssilva/Pictures/Wallpapers/11-0-Day.jpg"

# Create a bar for every monitor
bash <(hyprctl monitors -j |jq -r '.[] | "eww open-many mainbar:\(.id) -c ~/.config/eww/bar --arg \(.id):mon=\(.id)"') &

wl-paste -t text --watch clipman store --max-items 1024



