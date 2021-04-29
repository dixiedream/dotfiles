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

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliases" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliases"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/localAliases" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/localAliases"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
export KEYTIMEOUT=1

_fix_cursor() {
   echo -ne '\e[1 q'
}
precmd_functions+=(_fix_cursor)

# Load syntax highlighting; should be last.
#source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

