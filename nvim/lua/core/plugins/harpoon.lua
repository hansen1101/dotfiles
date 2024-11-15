require("harpoon").setup({})

local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")

vim.keymap.set("n", "<Leader>n", harpoon_ui.toggle_quick_menu, {})
vim.keymap.set("n", "<Leader>j", harpoon_ui.nav_next, {})
vim.keymap.set("n", "<Leader>k", harpoon_ui.nav_prev, {})
vim.keymap.set("n", "<Leader>t", harpoon_mark.toggle_file, {})
vim.keymap.set("n", "<Leader>c", harpoon_mark.clear_all, {})
