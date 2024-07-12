#!/bin/bash

# see man zscroll for documentation of the following parameters
zscroll -l 30 \
        --delay 0.1 \
        --scroll-padding " " \
        --match-command "`dirname $0`/get_spotify_status.sh --status" \
        --match-text "Playing" "--before-text '  ' --scroll true" \
        --match-text "Paused" "--before-text '  ' --scroll false" \
        --match-text "No player is running" "--before-text ''" \
        --update-check true "`dirname $0`/get_spotify_status.sh" &

wait

