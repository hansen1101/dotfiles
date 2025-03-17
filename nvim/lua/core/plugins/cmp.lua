return {
  -- Autocompletions
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-nvim-lua'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-cmdline'},
  {
    'hrsh7th/nvim-cmp',
    opts = function()
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
            -- -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          -- { name = 'vsnip' }, -- For vsnip users.
          { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
           -- { name = 'snippy' }, -- For snippy users.
          },{
          { name = "buffer" },
        }),
      })
    end,
  },
  {
    'saadparwaiz1/cmp_luasnip',
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Snippets
  {'hrsh7th/cmp-vsnip'},
  {'hrsh7th/vim-vsnip'},
  {'L3MON4D3/LuaSnip'},
  {'rafamadriz/friendly-snippets'},
}
