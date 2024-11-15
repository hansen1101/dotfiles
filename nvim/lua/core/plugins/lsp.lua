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

require("luasnip.loaders.from_vscode").lazy_load()

-- nvim-cmp config [https://github.com/hrsh7th/nvim-cmp]

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-v>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
	}),
	snippet = {
		expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
	}),
})

local on_attach = function(_, bufnr)
  --print("lsp attached to buffer ",bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

	vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

vim.api.nvim_create_augroup("SessionMgmt", {})

vim.api.nvim_create_autocmd(
    "BufWinEnter",
    {
        pattern = {"*"},
        group = "SessionMgmt",
        callback = function()
            vim.cmd("silent! loadview") -- load folds
        end,
    }
)

vim.api.nvim_create_autocmd(
    "BufWinLeave",
    {
        pattern = {"*"},
        group = "SessionMgmt",
        callback = function()
            vim.cmd("silent! mkview") -- save current folds
        end,
    }
)

vim.api.nvim_create_augroup("AutoFormat", {})

vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
        pattern = {"*"},
        group = "AutoFormat",
        callback = function()
            vim.cmd("%s/\\s\\+$//e") -- remove trailing whitespace
        end,
    }
)

vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = {"*.yml", "*.yaml"},
        group = "AutoFormat",
        callback = function()
            --vim.cmd("silent !yamlfmt %")
            --vim.cmd("edit")
        end,
    }
)

vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = "*.py",
        group = "AutoFormat",
        callback = function()
            vim.cmd("silent !isort --quiet %")
            vim.cmd("silent !black --quiet %")
            vim.cmd("edit")
        end,
    }
)

vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = "*.rs",
        group = "AutoFormat",
        callback = function()
            vim.cmd("silent !rustfmt %")
            vim.cmd("edit")
        end,
    }
)
