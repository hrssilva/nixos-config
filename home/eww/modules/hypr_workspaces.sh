#!/usr/bin/env bash 


#define icons for workspaces 1-9
ic=(0         󰻧)

workspaces() {

	unset -v \
  o1 o2 o3 o4 o5 o6 o7 o8 o9 \
  f1 f2 f3 f4 f5 f6 f7 f8 f9

# Get occupied workspaces and remove workspace -99 aka scratchpad if it exists
# a="$(hyprctl workspaces | grep ID | awk '{print $3}')"
# a="$(echo "${a//-99/}" | sed '/^[[:space:]]*$/d')"
#ows="$(hyprctl workspaces -j | jq '.[] | del(select(.id == -99)) | .id')"
ows="$(hyprctl workspaces -j | jq 'sort_by(.id) | .[] | del(select(.id == -99)) | {"id": .id, "mon": .monitorID}')"
#ows="$(echo '$ows' | jq 'sort_by(.id)')"

#for num in $ows; do
#	export o"$num"="$num"
#done

# Get Focused workspace for current monitor ID
arg="$1"
scratchpad="-98"

#focused="$(hyprctl monitors -j | jq --argjson arg "$arg" '.[] | .activeWorkspace.id')"
focused="$(hyprctl monitors -j | jq '.[] | {"id": .id, "ws": .activeWorkspace.id}')"
#export f"$num"="$num"

#echo 	"(eventbox :onscroll \"echo {} | sed -e 's/up/-1/g' -e 's/down/+1/g' | xargs hyprctl dispatch workspace\" \
#          (box	:class \"workspace\"	:orientation \"h\" :space-evenly \"false\" 	\
#              (button :onclick \"modules/dispatch.sh 1\" :class \"w0$o1$f1\" \"${ic[1]} ₁\") \
#              (button :onclick \"modules/dispatch.sh 2\" :class \"w0$o2$f2\" \"${ic[2]} ₂\") \
#              (button :onclick \"modules/dispatch.sh 3\" :class \"w0$o3$f3\" \"${ic[3]} ₃\") \
#              (button :onclick \"modules/dispatch.sh 4\" :class \"w0$o4$f4\" \"${ic[4]} ₄\") \
#              (button :onclick \"modules/dispatch.sh 5\" :class \"w0$o5$f5\" \"${ic[5]} ₅\") \
#              (button :onclick \"modules/dispatch.sh 6\" :class \"w0$o6$f6\" \"${ic[6]} ₆\") \
#              (button :onclick \"modules/dispatch.sh 7\" :class \"w0$o7$f7\" \"${ic[7]} ₇\") \
#              (button :onclick \"modules/dispatch.sh 8\" :class \"w0$o8$f8\" \"${ic[8]} ₈\") \
#              (button :onclick \"modules/dispatch.sh 9\" :class \"w0$o9$f9\" \"${ic[9]} ₉\") \
#          )\
#        )"

JSON_STRING=$(jq -n '{}')

for monId in $(echo "$focused" | jq '.id'); do
	JSON_STRING=$( echo "$JSON_STRING" | jq --arg monId "$monId" '. += {($monId): []}')
done


for wsId in $(echo "$ows" | jq '.id'); do
    wsMon=$(echo "$ows" | jq --arg wsId "$wsId" 'select(.id == ($wsId | tonumber)) | .mon')
    focus=$(echo "$focused" | jq --arg monId "$wsMon" 'select(.id == ($monId | tonumber)) | .ws')
    if [ $wsId -eq $focus ]; then
	    class="focused"
	    icon=""
    elif [ $wsId -eq $scratchpad ]; then
	    wsId=""
	    class="focused"
	    icon="[S]"
    else
	    class="visible"
	    icon=""
    fi
    JSON_STRING=$( echo "$JSON_STRING" | jq \
	          --arg item "$wsMon" \
                  --arg workspace "$wsId" \
		  --arg cls "$class" \
		  --arg ic "$icon" \
		  '.[($item)][.[($item)] | length] |= . + {name: $workspace, class: $cls, icon: $ic}')

done
echo "$JSON_STRING" | jq -c .

}

workspaces $1 
socat -u UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock - | while read -r; do 
workspaces $1
done

