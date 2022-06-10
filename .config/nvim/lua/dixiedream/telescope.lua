local telescope = require('telescope')
telescope.setup {
    defaults = {
        preview = false -- Preview disabled
    }
}
telescope.load_extension('fzf')

local project_search = function()
   require('telescope.builtin').live_grep()
end

local project_files = function()
    local opts = {}
    local ok = pcall(require('telescope.builtin').git_files, opts)
    if not ok then require('telescope.builtin').find_files(opts) end
end

vim.keymap.set('n', '<Leader>ps', project_search, {noremap = true, silent = true})
vim.keymap.set('n', '<C-p>', project_files, {noremap = true, silent = true})
