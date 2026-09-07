Repository for personal configurations and settings.

## Layout:
- `nvim/`, `zsh/`, `tmux/` -> config, symlinked into place by the `Makefile`
- `scripts/` -> helper scripts installed to `~/.local/bin`
- `ubuntu/` -> Ubuntu/GNOME desktop settings
  - `settings/keyboard/` -> backup and rollout of GNOME keyboard shortcuts
    between machines, see [its README](ubuntu/settings/keyboard/README.md)
  - `settings/desktop/` -> backup and rollout of GNOME desktop behaviour
    (`gsettings`/dconf settings that are not shortcuts), see
    [its README](ubuntu/settings/desktop/README.md)
  - `settings/fonts/` -> Nerd Font installer, needed for the icons in lazygit,
    nvim and tmux, see [its README](ubuntu/settings/fonts/README.md)

## Dependencies:
- fzf
  ```bash
  # ubuntu
  $ sudo apt install fzf

  # mac
  $ brew install fzf
  ```

- oh-my-zsh -> need to be installed to ~/.local/opt/oh-my-zsh
- npm -> required for Mason
- packer -> required for nvim plugins
- dconf -> required for the `ubuntu/settings/keyboard` and
  `ubuntu/settings/desktop` scripts (ubuntu only, ships with GNOME)
