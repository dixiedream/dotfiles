local harpoon = require("harpoon")
harpoon.setup()

local harpoonUI = require("harpoon.ui")
vim.keymap.set('n', '<leader>a', function() require("harpoon.mark").add_file() end, {desc = "Mark file", silent = true, noremap = true })
vim.keymap.set('n', '<C-e>', harpoonUI.toggle_quick_menu, {desc = "Toggle quick menu", silent = true, noremap = true })

for key = 1, 5 do
  local keymap = string.format('<leader>%d', key)
  local description = string.format('Go to file %d', key)
  vim.keymap.set('n', keymap, function() harpoonUI.nav_file(key) end, {desc = description, silent = true, noremap = true })
end
