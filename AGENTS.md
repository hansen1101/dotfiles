# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal dotfiles. There is no build, no test suite, and no linter — "correct"
means the config loads in the real program. Verification is: run the relevant
`make` target, then reload (`source ~/.zshrc`, `tmux source-file ~/.config/tmux/tmux.conf`,
restart nvim) and look for errors.

## Repository layout: bare repo + per-topic worktrees

The checkout lives under `dotfiles.git/` as a **bare** repo with one worktree
per config area, each on its own long-lived branch:

```
dotfiles.git/wt-master, wt-nvim, wt-tmux, wt-zsh, wt-lazygit, ...
```

Work stays inside the worktree it belongs to (nvim changes on the `nvim`
branch, etc.) and reaches `master` via PR. Never `cd` to another worktree to
make an edit — check out or create the matching one instead.

## Installation is the Makefile, and it is destructive

`make` symlinks `$(CURDIR)/<dir>` into `~/.config/`, deleting whatever is
already there (`rm -rf $(HOME)/.config/nvim`, same for `zsh`) before linking.

| Target | Effect |
| --- | --- |
| `make` / `make all` | `tmux-sessionizer` + `zsh` + `nvim` |
| `make nvim` | `~/.config/nvim` -> `<worktree>/nvim` |
| `make zsh` | `~/.config/zsh` -> `<worktree>/zsh`, `~/.zshenv` -> `zsh/.zshenv`, and creates the machine-local dirs below |
| `make tmux-sessionizer` | **copies** the script to `~/.local/bin` (a copy, not a link — re-run after editing it) |
| `make gnome-shortcuts` | symlinks the two `ubuntu/settings/keyboard/bin` scripts into `~/.local/bin`; ubuntu-only, deliberately not in `all` |

**Because `$(CURDIR)` is absolute, running a target repoints the live config at
whatever worktree you ran it from.** The live symlinks currently point at the
*topic* worktrees (`~/.config/nvim` -> `wt-nvim/nvim`), so running `make nvim`
from an unrelated worktree silently hijacks the user's editor config. Don't run
install targets to "test" a change unless the user asked for it.

There is no `tmux` target — `~/.config/tmux` was symlinked by hand.

## zsh: the ZDOTDIR chain, and where machine-local settings go

`~/.zshenv` (symlink) sets `ZDOTDIR=$HOME/.config/zsh`, so zsh reads
`.zprofile` and `.zshrc` from the repo. `.zshrc` ends by sourcing, if present:

- `~/.config/zsh-inits/conda` — tool init blocks (conda, sdkman)
- `~/.config/zsh-exports/path`, `~/.config/zsh-exports/custom` — per-machine exports

These are created empty by `make zshcustom` and are **not** in the repo. Anything
host-specific (secrets, machine paths, tool bootstrap) belongs there, not in
`.zshrc`.

## nvim: packer, and adding a plugin touches three files

Plugin manager is **packer** (not lazy.nvim). `init.lua` -> `lua/core/init.lua`
-> `packer`, `remap`, `set`, `plugins`. To add a plugin:

1. `use {...}` entry in `lua/core/packer.lua`
2. its config in `lua/core/plugins/<name>.lua`
3. `require('core.plugins.<name>')` in `lua/core/plugins/init.lua`

Then `:PackerSync`. `plugin/packer_compiled.lua` is generated and gitignored.
LSP servers are managed by mason (`lua/core/plugins/lsp.lua`) and need npm.

## tmux

`tmux/plugins/tpm` is a **git submodule** — a fresh clone needs
`git submodule update --init`. Plugins tpm installs alongside it are gitignored
(`tmux/plugins/tmux*`). `tmux.conf` reads `$CATPPUCCIN_FLAVOUR` for the theme,
so it must be exported in the environment before tmux starts.

## ubuntu/settings/keyboard

GNOME shortcuts backed up as a dconf keyfile (`gnome-shortcuts.ini`) rather than
the binary dconf DB, so they diff and merge. `gnome-shortcuts-backup` rewrites
`dconf dump` section headers to be relative to `/org/gnome/` so the whole file
reloads with one `dconf load`. Restore defaults to a *merge*; `--clean` resets
the subtrees first for an exact rollout. Details and caveats (GNOME version
matching, extensions not covered) are in that directory's README.
