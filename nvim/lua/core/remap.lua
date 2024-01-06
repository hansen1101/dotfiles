vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

--vim.keymap.set("n", "<leader>n", ":NERDTreeFocus<CR>")
--vim.keymap.set("n", "<C-n>", ":NERDTree<CR>")
--vim.keymap.set("n", "<C-t>", ":NERDTreeToggle<CR>")
--vim.keymap.set("n", "<C-f>", ":NERDTreeFind<CR>")

vim.keymap.set("n", "<C-j>", "<C-W><C-J>")
vim.keymap.set("n", "<C-k>", "<C-W><C-K>")
vim.keymap.set("n", "<C-l>", "<C-W><C-L>")
vim.keymap.set("n", "<C-h>", "<C-W><C-H>")

-- move active line up or down
vim.keymap.set("n", "J", ":m .+1<CR>==")
vim.keymap.set("n", "K", ":m .-2<CR>==")

-- highlight stuff and move around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- jump half page down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep cursor fixed in middle while jumping through search results 
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- visual mode only: select black whole register -> delete selection -> paste in from active registry ""
vim.keymap.set("x", "<leader>p", "\"_dP")

--Move cursor between lines withouth start indents
--vim.keymap.set("n", "<silent> <C-S-Up>", ":let @/='^[^ ]'<CR>N:nohlsearch<CR>")
--vim.keymap.set("n", "<silent> <C-S-Down>", ":let @/='^[^ ]'<CR>n:nohlsearch<CR>")

-- search and replace word under current marker position
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
