# GNOME desktop settings

Backup and rollout of GNOME desktop *behaviour* between Ubuntu machines —
everything you would set with `gsettings set …` that is not a keyboard
shortcut:

```bash
gsettings set org.gnome.mutter workspaces-only-on-primary true
```

`gsettings` is a typed front-end over dconf, so that call writes the dconf key
`/org/gnome/mutter/workspaces-only-on-primary`. These scripts dump the relevant
subtrees to `gnome-desktop.ini`, a plain-text dconf keyfile that is diffable and
safe to commit — the same mechanism as
[`settings/keyboard`](../keyboard/README.md), pointed at different paths.

## Layout

```
ubuntu/settings/desktop/
├── README.md
├── gnome-desktop.ini              the backup; header records host, GNOME version, date
└── bin/
    ├── gnome-desktop-backup       writes the keyfile
    └── gnome-desktop-restore      applies the keyfile
```

Installed into `~/.local/bin` from the repo root:

```bash
make gnome-desktop
```

Ubuntu-only, so it is not part of `make all`. Re-run it on each new machine
after cloning.

## Back up

```bash
gnome-desktop-backup ~/dotfiles/ubuntu/settings/desktop/gnome-desktop.ini
```

## Restore on another machine

```bash
gnome-desktop-restore --clean ~/dotfiles/ubuntu/settings/desktop/gnome-desktop.ini
```

`--clean` resets the keys this file owns to stock defaults before loading, so
the target ends up matching the source exactly. Without it, `dconf load`
**merges**: a key you reset to its default on the source stays at whatever the
target had. Use `--clean` for rollout, plain restore for patching a single
machine.

Unlike the shortcuts script, `--clean` here does *not* `dconf reset -f` whole
subtrees — `/org/gnome/mutter/` and `/org/gnome/shell/` have keybinding sections
nested inside them that `gnome-shortcuts.ini` owns. It resets key by key
instead, so the two files never clobber each other and the order you restore
them in does not matter.

Most changes apply immediately. `enabled-extensions` and GNOME Shell settings
generally need the shell reloaded (log out and back in on Wayland).

If the scripts aren't on the target machine, the merge restore is one command:

```bash
dconf load /org/gnome/ < gnome-desktop.ini
```

## What's covered

Subtrees under `/org/gnome/`, listed in `PATHS` in both scripts:

- `mutter` — tiling, `workspaces-only-on-primary`, workspace behaviour
- `desktop/wm/preferences` — titlebar buttons, focus mode, workspace count
- `desktop/interface` — theme, icon theme, colour scheme, UI font
- `desktop/peripherals` — mouse and touchpad
- `desktop/input-sources` — keyboard layout and xkb options
- `desktop/session`, `settings-daemon/plugins/power` — idle and sleep timeouts
- `desktop/screensaver`, `desktop/background` — wallpaper and lock screen
- `desktop/notifications` — banners, per-application notification settings
- `shell` — favourites, enabled extensions, per-extension settings
- `nautilus` — file manager view preferences

To add an area, put its path in `PATHS` in **both** scripts and re-run the
backup.

## What's deliberately excluded

Two lists in both scripts, kept in sync with each other:

`EXCLUDE_SECTIONS` / `EXCLUDE_KEYS` drop everything owned by
`gnome-shortcuts.ini` (`mutter/keybindings`, `shell/keybindings`,
`mutter/overlay-key`, `desktop/interface/gtk-key-theme`,
`shell/app-switcher/current-workspace-only`) so no key is written by both
files, plus per-machine noise that would churn the diff:
`shell/app-picker-layout` (depends on which apps are installed),
`shell/welcome-dialog-last-shown-version`, `nautilus/window-state`.

## Caveats

- **Match GNOME major versions.** Keys missing from the target's schemas are
  silently ignored by `dconf load`. Check the `gnome=` field in the file header.
- **`dconf dump` only emits non-default keys.** A setting still at its default
  is absent from the backup — that is what `--clean` compensates for.
- **Extension settings assume the extension is installed.** `shell/extensions/…`
  loads fine either way, but does nothing until the extension is present and
  listed in `enabled-extensions`.
- **Paths are machine-specific.** `picture-uri` points at a wallpaper file that
  must exist on the target, or the desktop falls back to a plain colour.
