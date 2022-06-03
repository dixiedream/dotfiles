# Enable colors and change prompt:
autoload -U colors && colors	# Load colors

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function precmd {
    PROMPT="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$fg[green]%}$(parse_git_branch)%{$reset_color%}$ "
}

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
#bindkey -e # Emacs mode
bindkey -v # Vim mode
export KEYTIMEOUT=1

typeset -g -A key
bindkey "^[[H" beginning-of-line
bindkey "\033[1~" beginning-of-line
bindkey "\033[4~" end-of-line

#-----------------------------
# Vim mode stuff
# ----------------------------
# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# ------------------------------
# Custom commands
# ------------------------------
bindkey -s ^f ". initSession\n" 
