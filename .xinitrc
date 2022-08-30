#!/bin/sh

# Environment variables
export AWT_TOOLKIT=MToolkit

userresources=$HOME/.config/Xresources

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

setbg & dunst & xcompmgr & unclutter -root & dwm_status & exec dwm
