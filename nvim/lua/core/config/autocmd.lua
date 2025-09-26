local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("autoupdate"),
  callback = function()
    if require("lazy.status").has_updates then
      require("lazy").update({ show = false, })
    end
  end,
})

-- Session Management
vim.api.nvim_create_augroup("SessionMgmt", {})

vim.api.nvim_create_autocmd(
    "BufWinEnter",
    {
        pattern = {"*"},
        group = "SessionMgmt",
        callback = function()
            vim.cmd("silent! loadview") -- load folds
            local cs = require("core.signs")
            cs.mark_signs()
        end,
    }
)
vim.api.nvim_create_autocmd(
    "BufWinEnter",
    {
        pattern = {"*.py","*.yaml","*.yml","*.json","*.go","*.scala","*.sbt"},
        group = "SessionMgmt",
        callback = function()
            --vim.opt_local.foldmethod = "indent"
            --vim.opt_local.foldenable = "off"
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

-- Auto Format
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
            --vim.cmd("silent !black --quiet %")
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

vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  {
    pattern = "*.spark",
    callback = function()
      vim.bo.filetype = "scala"
    end,
  }
)

vim.api.nvim_create_autocmd(
  "LspAttach",
  {
    callback = function(args)
      -- Unset 'formatexpr'
      vim.bo[args.buf].formatexpr = nil
      -- Unset 'omnifunc'
      vim.bo[args.buf].omnifunc = nil
      -- Map keys
      vim.keymap.set("n", "gp", function() vim.lsp.buf.definition() end,{ buffer = args.buf, remap = false })
      vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.hover() end, { buffer = args.buf, remap = false })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
      -- Disable document colors
      --vim.lsp.document_color.enable(false, args.buf)
    end,
  }
)
