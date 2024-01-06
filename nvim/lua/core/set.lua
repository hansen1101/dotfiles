vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.copyindent = true

vim.opt.softtabstop = 2 -- when editing a file 'tab key' use 2 spaces
vim.opt.tabstop = 2 -- show existing tab with 2 spaces width
vim.opt.shiftwidth = 2 -- when indenting with '>> <<', use 2 spaces
vim.opt.expandtab = true -- expand tabs to spaces

vim.opt.wrap = true 
vim.opt.colorcolumn = "80"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false -- do not highlight search
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"
--vim.opt.clipboard = "unnamed"

vim.opt.laststatus = 2
vim.opt.linebreak = true

vim.opt.statusline = "%<‹‹ %f %h%#error#%m%0*%r››%=%-14.(%l,%c%V%) %P"
--vim.opt.statusline = "%<‹‹ %f %h%#error#%m%0*%r››%<%1*%{FugitiveStatusline()}%0*%=%-14.(%l,%c%V%) %P"

vim.opt.signcolumn = "yes"

vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.ruler = false

vim.opt.background = "dark"
