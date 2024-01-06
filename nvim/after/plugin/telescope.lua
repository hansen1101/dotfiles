local builtin = require("telescope.builtin")
local fb = require("telescope").extensions.file_browser

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
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      follow_symlinks = false,
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
require("telescope").load_extension "file_browser"
