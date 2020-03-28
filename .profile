#
# ~/.profile
#

export EDITOR="vim"
export TERMINAL="st"
export BROWSER="brave"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X if not
# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
