# dotfiles
My arch dotfiles

## Information 

Here are some details about the setup:

- **OS:** [Arch Linux](https://archlinux.org)
- **WM:** [awesome](https://github.com/awesomeWM/awesome)
- **Terminal:** [st](https://github.com/dixiedream/st)
- **Shell:** [zsh](https://www.zsh.org/)
- **Editor:** [neovim](https://github.com/neovim/neovim) 
- **Compositor:** [xcompmgr](https://wiki.archlinux.org/title/Xcompmgr)
- **Application Launcher:** [dmenu](https://github.com/dixiedream/dmenu)


## Keybindings

### Window management
Modkey set as Super (Win/Mac Cmd) key
| Keybinding                | Action                                                                   |
|---------------------------|--------------------------------------------------------------------------|
| MODKEY + S               | opens the helper with all the WM shortcuts     |

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
