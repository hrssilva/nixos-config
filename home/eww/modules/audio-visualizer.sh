#!/usr/bin/env bash


# Map digits 0–8 to Unicode bars. Index 0 is space.
#blocks=(' ' ▂ ▃ ▄ ▅ ▆ ▇ █)

# Launch cava and map each digit to its corresponding block
#cava -p ~/.config/cava/eww_config | while IFS= read -r line; do
#  for (( i = 0; i < ${#line}; i++ )); do
#    d=${line:i:1}
#    # Output directly without building a string
#    [[ $d =~ [0-7] ]] && printf '%s' "${blocks[d]}" || printf ' '
#  done
#  printf '\n'
#done


# from [https://github.com/elkowar/eww/issues/230](https://github.com/elkowar/eww/issues/230)  
  
#bar="▁▂▃▄▅▆▇█"  
#dict="s/;//g;"  
  
# creating "dictionary" to replace char with bar  
#i=0  
#while \[ $i -lt ${#bar} \]; do  
#  dict="${dict}s/$i/${bar:$i:1}/g;"  
#  i=$((i = i + 1))  
#done  
  
# make sure to clean pipe  
#pipe="/tmp/cava.fifo"  
#if \[ -p $pipe \]; then  
#  unlink $pipe  
#fi  
#mkfifo $pipe  
  
printf "[general]\nframerate=60\nbars = 100\nsleep_timer=3\n[output]\nmethod = raw\nraw_target = /dev/stdout\ndata_format = ascii\nascii_max_range = 8\n" | cava -p /dev/stdin | sed -u 's/;//g;s/0/ /g;s/1/▁/g;s/2/▂/g;s/3/▃/g;s/4/▄/g;s/5/▅/g;s/6/▆/g;s/7/▇/g;s/8/█/g; '
