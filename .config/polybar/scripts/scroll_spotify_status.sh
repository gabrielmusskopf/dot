#!/bin/bash

# see man zscroll for documentation of the following parameters
zscroll -l 30 \
        --delay 0.1 \
        --before-text "  " \
        --scroll-padding " " \
        --match-command "`dirname $0`/get_spotify_status.sh --status" \
        --match-text "Playing" "--scroll true" \
        --match-text "Paused" "--scroll false" \
        --update-check true "`dirname $0`/get_spotify_status.sh" &

wait

