#!/bin/sh

# Environment variables
export WALLPAPER_DIR="$HOME/wallpapers"

userresources=$HOME/.config/Xresources

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xcompmgr & exec awesome
