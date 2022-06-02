# dotfiles
My arch dotfiles

## Information 

Here are some details about my setup:

- **OS:** [Arch Linux](https://archlinux.org)
- **WM:** [awesome](https://github.com/awesomeWM/awesome)
- **Terminal:** [st](https://github.com/dixiedream/st)
- **Shell:** [zsh](https://www.zsh.org/)
- **Editor:** [neovim](https://github.com/neovim/neovim) 
- **Compositor:** [xcompmgr](https://wiki.archlinux.org/title/Xcompmgr)
- **Application Launcher:** [dmenu](https://github.com/dixiedream/dmenu)


## Keybindings

### Window management
The only one to begin with is
| Keybinding                | Action                                                                   |
|---------------------------+--------------------------------------------------------------------------|
| MODKEY + S               | opens the helper with all the WM shortcuts     |

### Shell

| Keybinding                | Action                                                                   |
|---------------------------+--------------------------------------------------------------------------|
| CTRL + F               | fuzzy find my way to most common used directories  |

### Editor 
Leader set as ```space```

| Keybinding                | Action                                                                   |
|---------------------------+--------------------------------------------------------------------------|
| leader + y               | yank into registry (clipboard stuff) |
| leader + CarriageReturn | source out init.vim conf |
| leader + pv | open the explorer |
| leader + + | add split size |
| leader + - | reduce split size |
| CTRL + c               | exit from insert mode without press Esc |
| leader + ps | toggle project search | 
| CTRL + p | toggle fuzzy find file opening | 
| leader + e               | open diagnostics |
| gd               | go to definition |
| K               | toggle hover helper |
| leader + rn               | rename var |
| leader + ca               | code actions |
| gr               | open references |
| leader + f               | format |
