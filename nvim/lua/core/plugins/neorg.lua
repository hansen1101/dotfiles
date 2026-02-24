return {
  {
      "nvim-neorg/neorg",
      lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
      version = "*", -- Pin Neorg to the latest stable release
      --build = ":Neorg sync-parsers",
--      config = true,
      config = function()
        require("neorg").setup({
          load = {
            ["core.summary"] = {},
            ["core.highlights"] = {},
            ["core.integrations.treesitter"] = {},
            ["core.defaults"] = {},
            ["core.export"] = {},    -- Enable export module
            ["core.export.markdown"] = {},  -- Enable Markdown export
            ["core.concealer"] = {},
            ["core.dirman"] = {
              config = {
                workspaces = {
                  notes = "~/notes",
                },
                default_workspace = "notes",
              }
            },
            --["core.concealer"] = {
            --  config = {
            --    folds = true,
            --    icon_present = "diamond",
            --  }
            --},
            ["core.completion"] = {
              config = {
                engine = "nvim-cmp"
              }
            },
          },
        })
      end,
      dependencies = {
        { "nvim-neorg/tree-sitter-norg", },
        { "nvim-neorg/lua-utils.nvim", },
        { "pysan3/pathlib.nvim", },
        { "nvim-lua/plenary.nvim", },
        { "nvim-neorg/neorg-telescope" },
        {
            -- YOU ALMOST CERTAINLY WANT A MORE ROBUST nvim-treesitter SETUP
            -- see https://github.com/nvim-treesitter/nvim-treesitter
            "nvim-treesitter/nvim-treesitter",
            opts = {
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            },
            config = function(_,opts)
                require('nvim-treesitter.configs').setup(opts)
            end
        },
        --{ "folke/tokyonight.nvim", config=function(_,_) vim.cmd.colorscheme "tokyonight-storm" end,},
    },
  }
}
