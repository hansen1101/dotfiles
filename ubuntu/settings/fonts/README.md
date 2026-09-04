# Nerd Fonts

Patched fonts for the icons in lazygit, nvim (`nvim-web-devicons`, `lualine`)
and the catppuccin tmux theme.

Nerd Fonts are not packaged in apt, and the font files themselves are far too
large to vendor here, so this is an installer rather than a backup: it fetches
a release into `~/.local/share/fonts/NerdFonts/<Font>/` and rebuilds the font
cache.

## Layout

```
ubuntu/settings/fonts/
├── README.md
└── bin/
    └── nerd-font-install        fetches and installs a release
```

Symlinked into `~/.local/bin` from the repo root:

```bash
make nerd-fonts
```

## Install

```bash
nerd-font-install                     # JetBrainsMono, the default
nerd-font-install FiraCode Hack       # any number of release asset names
NERD_FONTS_VERSION=v3.4.0 nerd-font-install
```

One directory per font, wiped on each run, so re-running upgrades in place
instead of leaving old faces behind. *Windows Compatible* variants are skipped —
they duplicate every face and differ only in internal naming.

Then point the terminal at it (the script prints these):

```bash
p=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$p/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$p/ font 'JetBrainsMono Nerd Font Mono 12'
```

Each release ships three widths. **Nerd Font Mono** is the one you want in a
terminal: its icons are single-cell, so they sit in the character grid. Plain
*Nerd Font* has double-width icons that TUIs like lazygit will clip, and
*Nerd Font Propo* is proportional.

## Version 2 vs 3, and diagnosing tofu

Nerd Fonts v3 **moved the Material Design icons** from `U+F500-U+FD46` to
`U+F0001-U+F1AF0`. A v2 font with a v3-configured application (or the reverse)
therefore renders a subset: the Powerline and Font Awesome ranges did not move
and keep working, while the Material Design glyphs turn into tofu. lazygit
picks its range with `gui.nerdFontsVersion` in `~/.config/lazygit/config.yml`;
that must match the installed release.

fontconfig can answer "does any font here have this glyph" directly, which
beats guessing from how something looks:

```bash
fc-list ':charset=f062d' family      # a v3 Material Design icon
fc-list ':charset=f500'  family      # where the same icons lived in v2
fc-list ':charset=e0b0'  family      # Powerline, unmoved between versions
```

Empty output means no installed font covers that codepoint. If `e0b0` is the
only one that answers, and it answers with something like *OpenSymbol*, then no
Nerd Font is installed at all and you are seeing incidental fallback coverage
from an unrelated system font. The installer runs the `f062d` check at the end
for exactly this reason.

To find the codepoint behind a glyph you can paste:

```bash
python3 -c "print('U+%04X' % ord('󰘭'))"
```
