local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

for key = 1, 5 do
  local keymap = string.format('<leader>%d', key)
  vim.keymap.set('n', keymap, function() ui.nav_file(key) end)
end
