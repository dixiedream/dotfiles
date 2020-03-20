# Common alias file

# AwesomeWM
alias awesome-config="$EDITOR $HOME/.config/awesome/rc.lua"
alias awesome-theme-config="$EDITOR $HOME/.config/awesome/theme.lua"

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

# Dotfiles config
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Grub
alias grubedit="sudo vim /etc/default/grub"
alias grubsave="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# Download .m3u8 video streams
# https://stackoverflow.com/questions/32528595/ffmpeg-mp4-from-http-live-streaming-m3u8-file
streamDownload() {
    ffmpeg -i "$1" -c copy -bsf:a aac_adtstoasc movie.mp4
}

# Package manager
alias uninstall="sudo pacman -Rsu $1"

# Usb sticks formatting
alias format="sudo mkfs.$1 /dev/$2"
alias mkbootusb="dd bs=4M if=$1 of=/dev/$2 status=progress oflag=sync"
