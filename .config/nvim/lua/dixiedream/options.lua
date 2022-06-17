local options = {
    laststatus = 2,  -- set last window to always have status line
    number = true,  -- set numbered lines
    showmode = false, -- we don't need to see -- INSERT -- anymore
    expandtab = true, -- convert tabs to spaces
    smarttab = true, -- a Tab in front of a line inserts blanks
    shiftwidth = 4, -- number of spaces inserted for indentation
    tabstop = 4, -- insert spaces for tab
    mouse = "a", -- allow the mouse to be used in neovim
    splitbelow = true,
    splitright = true,
    wildmenu = true,
    incsearch = true,
    swapfile = false,
    termguicolors = true,
    relativenumber = true,
    nu = true,
    errorbells = false,
    signcolumn = "yes",
    hlsearch = false,
    sidescrolloff = 8,
    scrolloff = 8,
    writebackup = false,
    guifont = "monospace:12",
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd "set path+=**" -- Searches current directory recursively
-- vim.cmd "set fillchars+=:\\" -- Removes pipes acting as separator on splits

vim.cmd "set guioptions-=m" -- remove menu bar
vim.cmd "set guioptions-=T" -- remove toolbar
vim.cmd "set guioptions-=r" -- remove right-hand scrollbar
vim.cmd "set guioptions-=L" -- remove left-hand scrollbar

-- Ignores
vim.cmd "set wildignore+=*.pyc"
vim.cmd "set wildignore+=*_build/*"
vim.cmd "set wildignore+=**/coverage/*"
vim.cmd "set wildignore+=**/node_modules/*"
vim.cmd "set wildignore+=**/android/*"
vim.cmd "set wildignore+=**/ios/*"
vim.cmd "set wildignore+=**/.git/*"
