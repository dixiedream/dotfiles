# Common alias file

# Listing
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'

# Archives
#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


# Audio
alias audio="pavucontrol"

# Bluetooth
alias bt="bluetoothctl"

# Dotfiles config
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# DMenu
alias dmrefresh="rm -rf ~/.cache/dmenu_run"

# Grub
alias grubedit="sudo vim /etc/default/grub"
alias grubsave="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# Package manager
alias uninstall="sudo pacman -Rsu $1"

