#
# ~/.bash_profile
#

export FONT="Terminus"
export FONT_MONO="Inconsolata"
export EDITOR="vim"
export TERMINAL="urxvt"

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X if not
# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
