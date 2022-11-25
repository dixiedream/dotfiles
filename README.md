# .dotfiles
My dotfiles, theme heavily inspired by [AwesomeWM multicolor](https://github.com/lcpz/awesome-copycats#gallery)

![screenshot](https://github.com/dixiedream/dixiedream/blob/main/rice.png)

## Information
Some details about the setup:

- **OS:** [Arch Linux](https://archlinux.org)
- **WM:** [dwm](https://github.com/dixiedream/dwm)
- **Terminal:** [st](https://github.com/dixiedream/st)
- **Shell:** [zsh](https://www.zsh.org/)
- **Editor:** [neovim](https://github.com/neovim/neovim)
- **Compositor:** [xcompmgr](https://wiki.archlinux.org/title/Xcompmgr)
- **Application Launcher:** [dmenu](https://github.com/dixiedream/dmenu)
- **Rice colorscheme:** [nord](https://www.nordtheme.com/)

*those details vary depending of the distribution I'm currently in, different init systems and display servers*

## Keybindings

### Shell

| Keybinding                | Action                                                                   |
|---------------------------|--------------------------------------------------------------------------|
| CTRL + F               | fuzzy find my way to most common used directories  |

### Editor
Leader set as ```space```

| Keybinding                | Action                                                                   |
|---------------------------|--------------------------------------------------------------------------|
| LEADER + y               | yank into registry (clipboard stuff) |
| LEADER + CarriageReturn | source out init.vim conf |
| LEADER + pv | open the explorer |
| LEADER + + | add split size |
| LEADER + - | reduce split size |
| CTRL + c               | exit from insert mode without press Esc |
| LEADER + ps | toggle project search |
| CTRL + p | toggle fuzzy find file opening |
| LEADER + e               | open diagnostics |
| gd               | go to definition |
| K               | toggle hover helper |
| LEADER + rn               | rename var |
| LEADER + ca               | code actions |
| gr               | open references |
| LEADER + f               | format |

## Install
The best way to install is through my [ansible scripts](https://github.com/dixiedream/ansible.git)
