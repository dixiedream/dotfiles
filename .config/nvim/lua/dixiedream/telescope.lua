local telescope = require('telescope')
telescope.setup {
    defaults = {
        preview = false -- Preview disabled
    }
}

telescope.load_extension('fzf')

local builtin = require("telescope.builtin")
local project_files = function()
    local opts = {}
    local ok = pcall(builtin.git_files, opts)
    if not ok then builtin.find_files(opts) end
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader>ps', function() builtin.live_grep() end, opts)
vim.keymap.set('n', '<Leader>E', function() builtin.diagnostics() end, opts)
vim.keymap.set('n', '<C-p>', project_files, opts)
