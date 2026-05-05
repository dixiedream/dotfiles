#!/bin/sh

userresources=$HOME/.config/Xresources
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

command -v gsettings >/dev/null 2>&1 &&
	gsettings set org.gnome.desktop.interface color-scheme prefer-dark 2>/dev/null
command -v dbus-update-activation-environment >/dev/null 2>&1 &&
	dbus-update-activation-environment --all 2>/dev/null

setbg &

autostart="dunst xcompmgr unclutter dwmblocks"
for program in $autostart; do
  pidof -s "$program" || "$program" &
done >/dev/null 2>&1

exec dwm
