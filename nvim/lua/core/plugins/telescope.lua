local builtin = require("telescope.builtin")
local fb = require("telescope").extensions.file_browser
local hp = require("telescope").extensions.harpoon

-- Create an alias for the :Telescope command prefix with autocomplete capabilities
vim.api.nvim_create_user_command(
  'T',
  function(opts)
    -- Call the corresponding Telescope command
    vim.cmd('Telescope ' .. table.concat(opts.fargs, ' '))
  end,
  { nargs = '*',
    complete = function(ArgLead, CmdLine, CursorPos)
      -- Use Telescope's built-in command completion
      local telescope_builtin = require('telescope.builtin')
      local commands = vim.tbl_keys(telescope_builtin)
      return vim.tbl_filter(function(cmd)
        return string.match(cmd, '^' .. ArgLead)
      end, commands)
    end
  }
)

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set("n", "<Leader>f", fb.file_browser, {})
vim.keymap.set("n", "<Leader>g", builtin.live_grep, {})
vim.keymap.set("n", "<Leader>o", builtin.oldfiles, {})


require('telescope').setup{
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
}

-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension("file_browser")
require("telescope").load_extension('harpoon')
