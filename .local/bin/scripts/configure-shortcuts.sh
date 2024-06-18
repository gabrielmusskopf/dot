#!/bin/bash

BEGINNING="gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
CUSTOM_KEYBINDING_COUNT=8
CUSTOM_KEYBINDING_CURRENT=0

declare -a custom

for i in $(seq 0 $((CUSTOM_KEYBINDING_COUNT - 1))); do
  custom[i]="'$KEY_PATH/custom$i/'"
done

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$(IFS=", " ; echo "[${custom[*]}]")"

if ! command -v xdotool &> /dev/null; then
    echo "Installing xdotool to manage virtual desktops"
    sudo apt install xdotool
fi

# configure_keybinding name command binding
function configure_keybinding() {
    $BEGINNING/custom${CUSTOM_KEYBINDING_CURRENT}/ name "$1"
    $BEGINNING/custom${CUSTOM_KEYBINDING_CURRENT}/ command "$2"
    $BEGINNING/custom${CUSTOM_KEYBINDING_CURRENT}/ binding "$3"

    CUSTOM_KEYBINDING_CURRENT=$((CUSTOM_KEYBINDING_CURRENT + 1))
}

function configure_desktop_keybinding() {
    # Disable <Super>
    # https://askubuntu.com/a/1280308
    # gsettings set org.gnome.mutter overlay-key ''

    # Disable <Super><Num> to switch between apps
    # Ubuntu 24:
    # gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
    #
    # or, for Ubuntu 22.04:
    # for i in {1..9}; do gsettings set org.gnome.shell.keybindings switch-to-application-$i '[]'; done;

    declare -A keys
    keys[1]=1
    keys[2]=2
    keys[3]=3
    keys[q]=4
    keys[w]=5
    keys[e]=6

    echo "Configuring desktop keys"
    
    for key in "${!keys[@]}"; do
        desktop_num=${keys[$key]}
        desktop_i="$(($desktop_num-1))"
        configure_keybinding "Move to workspace $desktop_num" "xdotool set_desktop $desktop_i" "<Super>$key"
    done

    echo "Done"
}

configure_desktop_keybinding
configure_keybinding "Open Alacritty" "alacritty" "<Super>Return"
configure_keybinding "Open Browser" "brave-browser" "<Super>b"

# TODO: clipboard manager

echo "$CUSTOM_KEYBINDING_CURRENT keybinding configured"

