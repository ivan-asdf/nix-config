#!/bin/bash
set -e

if [ $# -eq 1 ]; then
    WALLPAPER="$1"
else
    WALLPAPERS_DIR=~/.config/wallpapers
    pushd $WALLPAPERS_DIR

    WALLPAPER=$(find . -type l | sort -R | tail -1)
    #ln -s -f "$WALLPAPER" .wallpaper
fi

betterlockscreen -u "$WALLPAPER" --fx blur
betterlockscreen -w
