local telescope = require('telescope')
telescope.setup {
    defaults = {
        preview = false -- Preview disabled
    }
}

telescope.load_extension('fzf')

local builtin = require("telescope.builtin")

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader>ps', function() builtin.live_grep() end, opts)
vim.keymap.set('n', '<Leader>pf', function() builtin.find_files() end, opts)
vim.keymap.set('n', '<Leader>E', function() builtin.diagnostics() end, opts)
vim.keymap.set('n', '<C-p>', function() builtin.git_files() end, opts)
