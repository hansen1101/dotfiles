return {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false;
      }
    }
  }
}
