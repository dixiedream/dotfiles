# Enable colors and change prompt:
autoload -U colors && colors	# Load colors

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function precmd {
    NEWLINE=$'\n'
    PROMPT="%B%F{red}%n%F{11}@%F{3}%M %F{green}%~ %F{magenta}$(parse_git_branch)%{$reset_color%}$NEWLINE%B%F{14}>%{$reset_color%} "
}

# NVM stuff
export NVM_LAZY_LOAD=true
source ~/.config/zsh/zsh-nvm/zsh-nvm.plugin.zsh

setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliases" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliases"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/localAliases" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/localAliases"

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.


#------------------------------
# Keybindings
#------------------------------
bindkey -e # Set EmacsMode, Zsh vi mode actually sucks
typeset -g -A key
bindkey "^[[H" beginning-of-line
bindkey "\033[1~" beginning-of-line
bindkey "\033[4~" end-of-line

# ------------------------------
# Custom commands
# ------------------------------
bindkey -s ^f ". initSession\n"
