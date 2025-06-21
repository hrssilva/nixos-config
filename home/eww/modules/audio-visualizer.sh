#!/usr/bin/env bash

cava -p ~/.config/cava/eww_config | while read -r line; do
  echo "$line" | tr '0123456789' ' ▁▂▃▄▅▆▇█'
done

