#!/bin/sh

# Environment variables
export WALLPAPER_DIR="$HOME/wallpapers"
export AWT_TOOLKIT=MToolkit

userresources=$HOME/.config/Xresources
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# Make caps lock a control
setxkbmap -option ctrl:nocaps
# Turn off caps lock if on since there is no longer a key for it.
xset -q | grep "Caps Lock:\s*on" && xdotool key Caps_Lock

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

setbg & xcompmgr & unclutter -root & dwm_status & exec dwm
