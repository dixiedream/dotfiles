#
# ~/.profile
#

export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="brave"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"


# ~/ Clean-up:
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="$HOME/.config/wget/wgetrc"
export INPUTRC="$HOME/.config/inputrc"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X if not
# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
