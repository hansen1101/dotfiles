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
├── fontconfig/
│   └── 10-nerd-font-fallback.conf   routes icon codepoints to the Mono cut
└── bin/
    └── nerd-font-install            fetches and installs a release
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

## Keeping your terminal font

You do **not** need to switch the terminal to a Nerd Font. `make nerd-fonts`
also links `fontconfig/10-nerd-font-fallback.conf` into
`~/.config/fontconfig/conf.d/`, which appends the Nerd Font as a *fallback* for
monospace. Text keeps rendering in whatever font the terminal is set to;
fontconfig only reaches for the Nerd Font for codepoints the base font lacks —
i.e. the icons.

Verify it, without changing anything:

```bash
fc-match monospace                    # unchanged: your normal text font
fc-match 'monospace:charset=f062d'    # JetBrainsMono Nerd Font Mono
```

The rule pins the **Mono** cut on purpose. Each release ships three widths, and
only `Nerd Font Mono` has single-cell icons. Plain `Nerd Font` and `Nerd Font
Propo` are wider than one cell, so a terminal grid clips them or loses
alignment — which looks like a *rendering* bug rather than a font-selection
one. Left to itself fontconfig will happily pick one of those wider cuts.

Restart the terminal after installing; VTE does not re-read fonts live. Inside
tmux, detach and reattach the client too.

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
