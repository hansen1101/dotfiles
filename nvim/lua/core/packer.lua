-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use({
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    requires = { {'nvim-lua/plenary.nvim'} }
  })

  use({
    'nvim-telescope/telescope-file-browser.nvim',
    requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
  })
  use({'nvim-tree/nvim-web-devicons'})

  use({'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'} })
  use({'nvim-telescope/telescope-fzf-native.nvim', { run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' } })
  use({'nvim-treesitter/playground'})

  use('mbbill/undotree')

  use({
    'ggandor/leap.nvim'
  })

  use({
    'rebelot/kanagawa.nvim'
  })

  use({
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 100,
    opts = {},
  })

  use({
    'altercation/vim-colors-solarized'
  })

  use({
    'mattn/webapi-vim'
  })

  use({
    'scalameta/nvim-metals',
    requires = { 'nvim-lua/plenary.nvim' }
  })

  use({
	  'neovim/nvim-lspconfig',
	  'williamboman/mason.nvim',
	  'williamboman/mason-lspconfig.nvim',
  })

  -- autocompletion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip'

  -- Snippets
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- Git
  use('tpope/vim-fugitive')
  use 'lewis6991/gitsigns.nvim'

end)
