return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = function()
      require('telescope').setup({
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          --vimgrep_arguments = {
          --  'rg',
          --  '--color=never',
          --  '--no-heading',
          --  '--with-filename',
          --  '--line-number',
          --  '--column',
          --  '--smart-case',
          --  '-u' -- thats the new thing
          --},
          --theme = "ivy",
          --require('telescope.themes').get_ivy(),
          --layout_strategy = 'vertical',
          --layout_config = {
          --  prompt_position = "top",
          --  width = vim.o.lines, -- max num of available lines
          --  height = vim.o.columns, -- max num of available columns
          --  preview_height = 0.8,
          --  width = 0.5,
          --},
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-h>"] = "which_key",
            },
          }
        },
        pickers = {
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
          live_grep = {
            theme = "ivy",
            additional_args = function(opts)
              print(opts)
              return {"--hidden"}
            end
          },
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            layout_strategy = "bottom_pane",
            layout_config = {
              height = 40,
            },
            follow_symlinks = true,
            respect_gitignore = false,
            no_ignore = false,
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                -- your custom insert mode mappings
              },
              ["n"] = {
                -- your custom normal mode mappings
              },
            },
          },
        },
      })
    end,
    cmd = "Telescope", -- Load Telescope only when the command is used
    keys = { 
      { "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>ff", "<cmd>Telescope file_browser<cr>", desc = "Browse Files" },
      { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>m", "<cmd>Telescope marks<cr>", desc = "Show Marks" },
      { "<leader>r", "<cmd>Telescope registers<cr>", desc = "Show Registers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
      { "<leader>fp", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Old Files" },
      { "<leader>fs",
        function()
          require("telescope.builtin").grep_string({ search = vim.fn.input('Grep >> ')})
        end,
        desc = "Live Grep Prompt"
      },
    },
    config = function()
      vim.api.nvim_create_user_command(
        'T',
        function(opts)
          -- Call the corresponding Telescope command
          vim.cmd('Telescope ' .. table.concat(opts.fargs, ' '))
        end,
        { nargs = '*',
          complete = function(ArgLead, CmdLine, CursorPos)
            -- Use Telescope's built-in command completion
            local builtin = require("telescope.builtin")
            local commands = vim.tbl_keys(builtin)
            return vim.tbl_filter(function(cmd)
              return string.match(cmd, '^' .. ArgLead)
            end, commands)
          end
        }
      )
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  }
}

