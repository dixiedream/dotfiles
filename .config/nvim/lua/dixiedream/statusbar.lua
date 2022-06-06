-- vim.g.lightline = {
--     colorscheme = 'nord',
--     active = {
--          left = { 
--              { 'mode', 'paste' },
--              { 'gitbranch', 'readonly', 'filename', 'modified' }
--        },
--    },
--    component_function = {
--         gitbranch = 'FugitiveHead'
--     },
-- }
--
--
require('lualine').setup {
    options = {
        icons_enabled = false
    }
}
