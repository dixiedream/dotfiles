#!/bin/sh

# Environment variables
export AWT_TOOLKIT=MToolkit

userresources=$HOME/.config/Xresources

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

setbg &

# autostart="dunst xcompmgr unclutter dwm_status"
autostart="dunst xcompmgr unclutter dwmblocks"
for program in $autostart; do
  pidof -s "$program" || "$program" &
done >/dev/null 2>&1

exec dwm
