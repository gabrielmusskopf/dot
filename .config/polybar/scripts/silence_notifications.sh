#!/bin/bash

declare -A BELL_STATUS=(
    ["false"]=""
    ["true"]=""
)

STATUS=$(dunstctl is-paused)

case "$1" in
    status)
        echo ${BELL_STATUS[$STATUS]}
        ;;
    toggle)
        dunstctl set-paused toggle
        ;;
    *)
        echo ""
        ;;
esac
