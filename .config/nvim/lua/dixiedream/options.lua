local options = {
  autowrite = false, -- don't auto save
  backup = false, -- don't create backup files
  completeopt = "menuone,noinsert,noselect", -- completion options
  errorbells = false, -- no error bells
  expandtab = true, -- convert tabs to spaces
  guifont = "monospace:12",
  hlsearch = false, -- don't highlight search results
  incsearch = true, -- slow matches as you type
  laststatus = 2, -- set last window to always have status line
  -- lazyredraw = true, -- don't redraw during macros
  maxmempattern = 20000, -- performance improvement
  mouse = "a",    -- allow the mouse to be used in neovim
  number = true,  -- set numbered lines
  redrawtime = 10000, -- performance improvement
  relativenumber = true,
  scrolloff = 8, -- lines kept above/below cursor
  shiftwidth = 2,   -- number of spaces inserted for indentation
  showmode = false, -- we don't need to see -- INSERT -- anymore
  sidescrolloff = 8, -- column kept left/right of cursor
  signcolumn = "yes", -- show sign column
  smartindent = true, -- smart auto-indent
  smarttab = true, -- a Tab in front of a line inserts blanks
  softtabstop = 2,
  splitbelow = true, -- horizontal splits go below
  splitright = true, -- vertical splits go right
  swapfile = false, -- no swap files
  tabstop = 2, -- insert spaces for tab
  termguicolors = true,
  undodir = os.getenv("XDG_CACHE_HOME") .. "/nvim/undodir",
  undofile = true, -- persistent undo
  updatetime = 300, -- faster completion
  wildmenu = true, -- advanced command-line completion
  wrap = false, -- don't wrap lines
  writebackup = false, -- don't create backup before writing
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.path:append({ "**" }) -- Searches current directory recursively

vim.opt.guioptions:remove({
  "m", -- remove menu bar
  "T", -- remove toolbar
  "r", -- remove right-hand scrollbar
  "L" -- remove left-hand scrollbar
})

-- Ignores
vim.opt.wildignore:append({
  "*.pyc",
  "*_build/*",
  "**/coverage/*",
  "**/node_modules/*",
  "**/android/*",
  "**/ios/*",
  "**/.git/*"
})

vim.diagnostic.config({
  virtual_text = false -- Disable inline diagnostic
})
