return {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    pylsp = {
      --configurationSources = {"flake8"},
      plugins = {
        flake8 = {
          enabled = false,
        },
        pylint = {
          -- https://docs.pylint.org/features.html#id19
          -- https://www.codeac.io/documentation/pylint-configuration.html
          --pylint --generate-toml-config
          enabled = true,
          executable = "pylint",
        },
        pycodestyle = {
          enabled = false,
          ignore = {'W391'},
          maxLineLength = 88,
        },
      },
    },
  },
}
