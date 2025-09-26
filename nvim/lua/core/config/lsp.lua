local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config.lua_ls = {
  ok_attach = on_attach,
  capabilities = capkbilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  }
}

vim.lsp.enable('lua_ls')
