#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/tmp/polybar.log; do sleep 1; done

# Launch bar on each monitor, tray on primary
polybar --list-monitors | while IFS=$'\n' read line; do
  monitor=$(echo $line | cut -d':' -f1)
  primary=$(echo $line | cut -d' ' -f3)
  MONITOR=$monitor polybar --reload "top${primary:+"-primary"}" &
done
