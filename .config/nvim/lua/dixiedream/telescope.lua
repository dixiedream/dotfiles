local telescope = require('telescope')
telescope.setup {
    defaults = {
        preview = false -- Preview disabled
    }
}
telescope.load_extension('fzf')

local M = {}

M.project_search = function()
   require('telescope.builtin').live_grep()
end

M.project_files = function()
    local opts = {}
    local ok = pcall(require('telescope.builtin').git_files, opts)
    if not ok then require('telescope.builtin').find_files(opts) end
end

vim.api.nvim_set_keymap('n', '<Leader>ps', ':lua require\'dixiedream.telescope\'.project_search()<Cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-p>', ':lua require\'dixiedream.telescope\'.project_files()<Cr>', {noremap = true, silent = true})

return M
