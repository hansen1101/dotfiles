return {
  {
    "ggandor/leap.nvim",
    config = function()
      local leap = require("leap")

      -- Recommended default mappings
      leap.add_repeat_mappings(";", ",", {
        relative_directions = true,
        modes = { "n", "x", "o" },
      })

      vim.keymap.set({ "n", "x", "o" }, "s", function()
        leap.leap({ target_windows = { vim.fn.win_getid() } })
      end)

      vim.keymap.set({ "n", "x", "o" }, "S", function()
        leap.leap({ target_windows = require("leap.util").get_enterable_windows() })
      end)
    end,
  },
}
