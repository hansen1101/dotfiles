return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = function(_, bufnr)
        --print("lsp attached to buffer ",bufnr)
        local opts = {buffer = bufnr, remap = false}

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
      end

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        }
      })

      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      --lspconfig.pyright.setup({
      --	on_attach = on_attach,
      --	capabilities = capabilities,
      --	settings = {
      --		Lua = {
      --			diagnostics = {
      --				globals = { "vim" },
      --			},
      --		},
      --	}
      --})

      lspconfig.rust_analyzer.setup{
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          ['rust-analyzer'] = {
            diagnostics = {
              enable = false;
            }
          }
        }
      }

      -- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
      lspconfig.pylsp.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          pylsp = {
            --configurationSources = {"flake8"},
            plugins = {
              flake8 = {
                enabled = false,
              },
              pylint = {
                -- https://docs.pylint.org/features.html#id19
                -- https://www.codeac.io/documentation/pylint-configuration.html
                --pylint --generate-toml-config
                enabled = true,
                executable = "pylint",
              },
              pycodestyle = {
                enabled = false,
                ignore = {'W391'},
                maxLineLength = 88,
              },
            },
          },
        },
      })

      lspconfig.htmx.setup({})
    end,
  },
  {
    "williamboman/mason.nvim",
    version = "1.11.0"
  },
  {
    'williamboman/mason-lspconfig.nvim',
    version = "1.32.0",
    opts = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
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
