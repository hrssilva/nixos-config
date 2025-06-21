#!/usr/bin/env bash
MONID=$(hyprctl monitors -j | jq --arg monname "$1" '.[] | select(.name==$monname) | .id')
sleep 2.5
eww open mainbar --arg mon=$MONID
swww img "/home/hrssilva/Pictures/Wallpapers/11-0-Day.jpg" --outputs $1
