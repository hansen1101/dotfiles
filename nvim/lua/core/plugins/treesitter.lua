return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    --opts = {
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })
      require("nvim-treesitter").install({
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        "bash",
        "c",
        "go",
        "html",
        "java",
        "javascript",
        "json",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        --"norg",
        "python",
        "query",
        "rust",
        "scala",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",

      })
    end,
  }
}
