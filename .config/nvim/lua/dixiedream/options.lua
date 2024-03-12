local options = {
    errorbells = false,
    guifont = "monospace:12",
    hlsearch = false,
    incsearch = true,
    laststatus = 2,  -- set last window to always have status line
    mouse = "a", -- allow the mouse to be used in neovim
    nu = true,
    number = true,  -- set numbered lines
    relativenumber = true,
    scrolloff = 8,
    showmode = false, -- we don't need to see -- INSERT -- anymore
    sidescrolloff = 8,
    signcolumn = "yes",
    smartindent = true,
    smarttab = true, -- a Tab in front of a line inserts blanks
    splitbelow = true,
    splitright = true,
    swapfile = false,
    backup = false,
    undodir = os.getenv("XDG_CACHE_HOME") .. "/nvim/undodir",
    undofile = true,
    tabstop = 2, -- insert spaces for tab
    softtabstop = 2,
    shiftwidth = 2, -- number of spaces inserted for indentation
    expandtab = true, -- convert tabs to spaces
    termguicolors = true,
    wildmenu = true,
    wrap = false,
    writebackup = false,
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

vim.diagnostic.config({
  -- Disable inline diagnostic
  virtual_text = false
})
