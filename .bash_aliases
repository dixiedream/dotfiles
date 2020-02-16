# Common alias file

# Listing
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'

# Dotfiles config
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Package manager
alias uninstall="sudo pacman -Rsu $1"

# Bootloader stuff
alias editgrub="sudo $EDITOR /etc/default/grub"
