#
# ~/.bash_profile
#

export EDITOR="vim"


#[[ -f ~/.scripts/shortcuts.sh ]] && ~/.scripts/shortcuts.sh

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X if not
if [ "$(tty)" = "/dev/tty1" ]; then
	pgrep -x awesome || exec startx
fi
