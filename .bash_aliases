# Common alias file

# Listing
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'

# Audio
alias audio="pavucontrol"

# Bluetooth
alias bt="bluetoothctl"
alias bton="bluetoothctl power on"
alias btoff="bluetoothctl power off"

# Dotfiles config
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Grub
alias grubedit="sudo vim /etc/default/grub"
alias grubsave="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# Email
alias email="firefox https://mail.google.com https://outlook.live.com/mail/inbox"

# Package manager
alias uninstall="sudo pacman -Rsu $1"

# Usb sticks
alias usbconnect="udisksctl mount -b $1"
alias usbdisconnect="udisksctl unmount -b $1"

# Bootloader stuff
alias editgrub="sudo $EDITOR /etc/default/grub"
