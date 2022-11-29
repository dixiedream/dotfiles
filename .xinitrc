#!/bin/sh

# Environment variables
export AWT_TOOLKIT=MToolkit

userresources=$HOME/.config/Xresources

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

setbg &

autostart="dunst xcompmgr unclutter pipewire dwm_status"
for program in $autostart; do
  pidof -s "$program" || "$program" &
done >/dev/null 2>&1

exec dwm
