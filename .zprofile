#!/bin/zsh

#
# Zsh profile file. Runs on login. Env vars are set here
# Symlinked to ~/.profile for bash fallback
#

# Adds `~/.local/bin` to $PATH
# export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"
# export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"
export PATH="$PATH:$HOME/.local/bin"

export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="brave"

# XDG Standards
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"

# GoLang stuff
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Other
export DOCKER_BUILDKIT=0 # temp fix for compose not building images
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm

# Start X if not
# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx
