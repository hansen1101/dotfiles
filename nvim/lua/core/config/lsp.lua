local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function(_, bufnr)
  print("lsp attached to buffer ",bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gp", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
  vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
end

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
