# nvim

Requires **Neovim >= 0.12** (uses `vim.lsp.enable` and the `nvim/lsp/` config
directory). Plugin manager is [lazy.nvim](https://github.com/folke/lazy.nvim),
which bootstraps itself on first start.

## Install

```bash
make nvim        # symlinks ~/.config/nvim -> <checkout>/nvim (deletes what was there)
```

Install the system dependencies below **before** the first start. The first
start clones every plugin, builds the norg parsers, compiles the treesitter
parsers and lets mason install LSP servers in the background. Keep that first
session open until `:Lazy` and `:Mason` are done — quitting early leaves
half-installed packages behind: links in `mason/bin` but no
`mason-receipt.json`, so every start retries and fails with `"…" is already
linked`. Fix with `:MasonUninstall <pkg>` then `:MasonInstall <pkg>` — not
`--force` while the startup auto-install is still running, the two race.

## System dependencies

| Tool | Needed by | mac | ubuntu |
| --- | --- | --- | --- |
| git, curl, C compiler, make | lazy, LuaSnip `jsregexp`, parser builds | Xcode CLT | `sudo apt install build-essential curl git` |
| `tree-sitter` CLI >= 0.25 | nvim-treesitter (`main` branch) compiles every parser with it — without it **no** parser gets installed | `brew install tree-sitter-cli` | `npm install -g tree-sitter-cli` or `cargo install --locked tree-sitter-cli` |
| cmake | telescope-fzf-native build | `brew install cmake` | `sudo apt install cmake` |
| node / npm | mason: pyright, eslint-lsp | `brew install node` | `sudo apt install nodejs npm` |
| python3 (+ venv, pip) | mason: python-lsp-server | system python | `sudo apt install python3-pip python3-venv` |
| go | mason: gopls | `brew install go` | see [go.dev/doc/install](https://go.dev/doc/install) |
| ripgrep | telescope live grep | `brew install ripgrep` | `sudo apt install ripgrep` |

Not needed: a system `lua5.1` / `luarocks`. lazy.nvim falls back to its own
`hererocks` to build luarocks dependencies (neorg's `tree-sitter-norg` and
`tree-sitter-norg-meta`). Both rocks have to be listed in neorg's
`dependencies` (`lua/core/plugins/neorg.lua`): lazy only adds a rock's parser to
`package.cpath` once that plugin is loaded, and neorg looks the parsers up while
it loads. A missing entry shows up as `norg_meta treesitter parser was not found`.

### Optional LSP servers

`lua/core/config/lsp.lua` also enables these, but nothing installs them. They
stay inactive until their binary is on `PATH`:

- `golangci_lint_ls` — `:MasonInstall golangci-lint-langserver golangci-lint`
- `htmx` — `:MasonInstall htmx-lsp` (built with cargo, so it needs Rust:
  `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`)

## Network: leap.nvim source

leap.nvim moved to **codeberg.org**; the GitHub repo was emptied in Oct 2026
(the last commits before that add a "moved to Codeberg" warning on every start).
Since 2026-11-18 codeberg.org is on registrar `clientHold` and does not resolve
anywhere (not a local DNS problem — check with
`whois codeberg.org | grep -i status`). Until that is lifted,
`lua/core/plugins/leap.lua` pins `ggandor/leap.nvim` to `f19d43590c4b`, the last
GitHub commit with the code and without the warning. Once codeberg.org resolves
again, switch back to `url = "https://codeberg.org/andyg/leap.nvim"` and run
`:Lazy sync`.

## Verify

```vim
:checkhealth lazy nvim-treesitter mason vim.lsp
```

## Adding a plugin

One file: create `lua/core/plugins/<name>.lua` returning a lazy spec table. It is
picked up automatically by `{ import = "core/plugins" }` in `lua/core/lazy.lua`.
Versions are pinned in `lazy-lock.json` (gitignored).
