# GNOME keyboard shortcuts

Backup and rollout of GNOME keyboard shortcuts between Ubuntu machines.

Shortcuts live in dconf (`~/.config/dconf/user`), a binary database — not a
text file you can edit or copy directly. These scripts dump the relevant
subtrees to `gnome-shortcuts.ini`, a plain-text dconf keyfile that is diffable
and safe to commit.

## Layout

```
ubuntu/settings/keyboard/
├── README.md
├── gnome-shortcuts.ini              the backup; header records host, GNOME version, date
└── bin/
    ├── gnome-shortcuts-backup       writes the keyfile
    └── gnome-shortcuts-restore      applies the keyfile
```

The scripts live in the repo and are symlinked into `~/.local/bin` from the
repo root:

```bash
make gnome-shortcuts
```

The target is not part of `make all` — it is ubuntu-only. Re-run it on each
new machine after cloning.

## Back up

```bash
gnome-shortcuts-backup ~/dotfiles/ubuntu/settings/keyboard/gnome-shortcuts.ini
```

## Restore on another machine

Copy `gnome-shortcuts.ini` across, then:

```bash
gnome-shortcuts-restore --clean ~/dotfiles/ubuntu/settings/keyboard/gnome-shortcuts.ini
```

`--clean` resets the shortcut subtrees to stock defaults before loading, so the
target ends up matching the source exactly. Without it, `dconf load` **merges**:
keys absent from the file keep whatever the target already had. Use `--clean`
for rollout, plain restore for patching a single machine.

Changes apply immediately — no logout or restart needed.

If the scripts aren't on the target machine, the restore is one command:

```bash
dconf load /org/gnome/ < gnome-shortcuts.ini
```

## What's covered

All shortcut settings under these dconf paths, combined into one file:

- `desktop/wm/keybindings` — windows, workspaces, switchers
- `mutter/keybindings`, `mutter/wayland/keybindings` — tiling
- `shell/keybindings` — overview, screenshots, dash launchers
- `settings-daemon/plugins/media-keys` — media keys and custom run-a-command shortcuts
- `terminal/legacy/keybindings` — gnome-terminal copy/paste etc.

Plus three related keys outside those subtrees: `mutter/overlay-key`,
`shell/app-switcher/current-workspace-only`, `desktop/interface/gtk-key-theme`.

`dconf dump` emits section headers relative to the path dumped, so the backup
script rewrites each `[/]` into e.g. `[desktop/wm/keybindings]`. That lets the
whole thing reload with a single `dconf load /org/gnome/`.

## Caveats

- **Match GNOME major versions.** Keys missing from the target's schemas are
  silently ignored by `dconf load`. Check the `gnome=` field in the file header.
- **Extension shortcuts are not included** — those live under
  `/org/gnome/shell/extensions/`. Add the path to `PATHS` in the backup script
  if needed.
- **X11 vs Wayland**: `mutter/wayland/keybindings` is captured but empty on X11.
- Copy/paste is *not* covered. `Ctrl+C`/`Ctrl+V` are handled per-application by
  each toolkit, not by the window manager, so they have no dconf setting. Only
  the gnome-terminal overrides are portable this way.
