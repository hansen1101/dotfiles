local M = {}

function M.mark_signs()
  local bufnr = vim.api.nvim_get_current_buf()
  local marks = vim.fn.getmarklist(bufnr)

  -- Clear old signs
  --vim.fn.sign_unplace("markSigns", { buffer = bufnr })

  for i, mark in ipairs(marks) do
    local name = mark.mark:sub(2)  -- Strip the `'` prefix (e.g., "'a" -> "a")
    local line = mark.pos[2]

    -- Skip special or non-visible marks
    if name:match("[a-zA-Z]") then
      local sign_name = "MarkSign_" .. name

      -- Define a sign for this mark letter (once)
      vim.fn.sign_define(sign_name, {
        text = name,
        texthl = "Identifier",  -- You can customize highlight groups
        linehl = "",
        numhl = ""
      })

      -- Place it
      vim.fn.sign_place(
        i,  -- Unique ID (can be anything unique-ish)
        "markSigns",  -- Group name
        sign_name,
        bufnr,
        { lnum = line, priority = 10 }
      )
    end
  end
end

return M
