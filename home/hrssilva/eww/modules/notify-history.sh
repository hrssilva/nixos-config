#!/usr/bin/env bash

#dunstctl history | jq -r '.data | .[] | map ({"summary":"\(.summary.data)", "body": "\(.body.data)"}) | .[0:8]' 
dunstctl history | jq -r '.data | .[] | {"head": .[0:8], "full": .}' 
