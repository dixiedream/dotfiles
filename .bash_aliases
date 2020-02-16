# Common alias file

# Listing
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'

# Dotfiles config
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Grub
alias grubedit="sudo vim /etc/default/grub"
alias grubsave="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# Package manager
alias uninstall="sudo pacman -Rsu $1"

# Bootloader stuff
alias editgrub="sudo $EDITOR /etc/default/grub"
