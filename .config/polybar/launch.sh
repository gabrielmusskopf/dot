#!/usr/bin/env bash

# Add this script to your wm startup file.
# sudo ln -s ~/.config/polybar/launch.sh /etc/init.d/polybar.sh

DIR="$HOME/.config/polybar/"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then

    # Make HDMI screen primary, if exist
    HDMI=$(xrandr --query | grep " connected" | grep "HDMI" | cut -d" " -f1)
    [ ! -z "$HDMI" ] &&  xrandr --output $HDMI --primary || xrandr --output eDP-1 --primary

    # Launch primary
    PRIMARY=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)
    MONITOR=$PRIMARY polybar top --config="$DIR"/config.ini --reload --log=trace 2>/tmp/polybar-top.log &
else
    polybar -q top -c "$DIR"/config.ini 2>/tmp/polybar-top.log &
fi

echo "polybar lauched"
