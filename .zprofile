#!/bin/zsh

#
# Zsh profile file. Runs on login. Env vars are set here
# Symlinked to ~/.profile for bash fallback
#

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"

export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"

# XDG Standards
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="$HOME/.config/wget/wgetrc"
export INPUTRC="$HOME/.config/inputrc"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"


# Other
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.
#export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm

# Start X if not
# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx
