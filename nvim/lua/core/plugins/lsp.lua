return {
  {
    'neovim/nvim-lspconfig',
  },
  {
    "williamboman/mason.nvim",
    --hversion = "1.11.0"
  },
  {
    'williamboman/mason-lspconfig.nvim',
    --version = "1.32.0",
    opts = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        -- required lsp servers
        ensure_installed = {
          "pyright",
          "rust_analyzer",
          "eslint",
          "lua_ls",
          "pylsp",
          "gopls",
        }
      })
    end,
  },
}
