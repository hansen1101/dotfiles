return {
  {
    -- TEMP (2026-11-18): codeberg.org is on registrar clientHold and does not resolve.
    -- Pinned to the last GitHub commit that still has the code and no "moved to Codeberg"
    -- startup warning (later commits add the warning, HEAD deletes everything).
    -- Revert to `url = "https://codeberg.org/andyg/leap.nvim"` once codeberg.org resolves again.
    "ggandor/leap.nvim",
    commit = "f19d43590c4b",
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
