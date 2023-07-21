local telescope = require('telescope')
telescope.setup {
    defaults = {
        preview = false -- Preview disabled
    }
}

-- telescope.load_extension('fzf')

local builtin = require("telescope.builtin")

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader>pf', builtin.find_files, opts)
vim.keymap.set('n', '<Leader>E', builtin.diagnostics, opts)
vim.keymap.set('n', '<C-p>', builtin.git_files, opts)
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
