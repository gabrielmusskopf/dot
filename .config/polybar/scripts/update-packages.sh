#!/bin/bash

pkgs="$(apt list --upgradable | wc -l)"
notify-send "Upgrading $pkgs packages"

OUTPUT=$(sudo /usr/bin/apt upgrade -y 2>&1)
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    notify-send "Packages upgraded!"
else
    notify-send "Error upgrading packages:" "$OUTPUT"
fi

