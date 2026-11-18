-- vim.lsp.enable takes a list; extra positional args are ignored (the 2nd is the `enable` flag).
-- Names must match the files in nvim/lsp/ and nvim-lspconfig's lsp/ directory.
vim.lsp.enable({ 'lua_ls', 'gopls', 'golangci_lint_ls', 'pylsp', 'rust_analyzer', 'htmx' })
