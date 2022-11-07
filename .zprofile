#!/bin/zsh

#
# Zsh profile file. Runs on login. Env vars are set here
# Symlinked to ~/.profile for bash fallback
#

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$HOME/.local/bin"

export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="brave"
export LAUNCHER="dmenu"

# Colorful less
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;36m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"

# XDG Standards
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# GoLang stuff
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:/usr/local/go/bin

# App specs
export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME}/android"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc-2.0"
export HISTFILE="${XDG_DATA_HOME}/history"
export INPUTRC="${XDG_CONFIG_HOME}/inputrc"
export LESSHISTFILE="-"
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"
export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx
