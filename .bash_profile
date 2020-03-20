#
# ~/.bash_profile
#

export FONT="Terminus"
export FONT_MONO="Inconsolata"
export EDITOR="vim"

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X if not
if [ "$(tty)" = "/dev/tty1" ]; then
	pgrep -x awesome || exec startx
fi
