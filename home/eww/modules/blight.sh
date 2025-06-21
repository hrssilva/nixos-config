#!/usr/bin/env bash

blight="$(brightnessctl -m)"
IFS=',' 

read -r -a array <<< "$blight"

echo "${array[3]//%}"



