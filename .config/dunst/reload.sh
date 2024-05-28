#!/bin/bash

# kill current dunst deamon
dpid="$(pidof dunst)"
if [ -n "$dpid" ]; then
    kill -9 $dpid
    echo "dunst killed"
fi

# kill gnome-shell notifications if its running
pid=$(pidof org.gnome.Shell.Notifications)
if [ -n "$pid" ]; then
    kill -9 $pid
    echo "gnome notification killed. pid = $pid"
fi

# launch dunst
dunst -conf ~/.config/dunst/dunstrc &>~/var/log/dunst.log &
echo "dunst launched"


