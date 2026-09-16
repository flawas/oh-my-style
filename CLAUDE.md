# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

`oh-my-style` is a minimalist [Oh My Posh](https://ohmyposh.dev/) prompt theme in the [Nord](https://www.nordtheme.com/) color scheme, plus two shell profile snippets (`profile.ps1` for PowerShell, `profile.zsh` for Zsh) that load the theme and also tune the shell's own command-line syntax highlighting (PSReadLine / zsh-syntax-highlighting) to match it.

There is no build, lint, or test tooling — this is a set of config/snippet files consumed directly by a shell.

## File layout

- `oh-my-style.json` — the Oh My Posh theme definition (schema v4). All colors live in the top-level `palette` block; segments reference them via `p:<key>` (e.g. `p:accent`).
- `profile.ps1` — snippet for `$PROFILE`. Installs Oh My Posh via `winget` if missing, initializes the theme, then configures `Set-PSReadLineOption -Colors` for the interactive command line.
- `profile.zsh` — snippet for `~/.zshrc`. Installs Oh My Posh and `zsh-syntax-highlighting` via `brew` if missing, initializes the theme, then sets `ZSH_HIGHLIGHT_STYLES`.
- `README.md` — user-facing install/usage docs (German).

## Critical invariant: single source of truth for colors

**Every color used anywhere in this repo must be defined once, in the `palette` object of `oh-my-style.json`, and nowhere else.** This was an explicit, repeated user requirement — do not hardcode hex values in `profile.ps1` or `profile.zsh`.

- `profile.ps1` reads the palette at runtime via `(Get-Content $ohMyStyleConfig -Raw | ConvertFrom-Json).palette` and maps its keys onto PSReadLine token names (`Command`, `Parameter`, `String`, etc.).
- `profile.zsh` has no `jq`/`python` dependency; it extracts a given palette key at runtime with a small `sed`-based helper (`_oh_my_style_color`) that scans the `"palette": { ... }` block of `oh-my-style.json` for `"<key>": "<value>"`. If you rename or restructure the `palette` block (e.g. nest it, split it into multiple lines differently, or add multi-line values), update this helper's `sed` pattern.
- When adding a new syntax-highlighting mapping (PSReadLine token or `ZSH_HIGHLIGHT_STYLES` key) that needs a color not yet in the palette, add the color to `oh-my-style.json`'s `palette` first, then reference it by key from both profile scripts — never inline a new hex value in the profile scripts themselves.
- Current palette keys: `bg`, `bg_light`, `fg`, `muted`, `accent`, `warn`, `danger`, `parameter`, `string`, `number`, `variable`. `bg`/`bg_light` are prompt-segment backgrounds; the rest double as both Oh My Posh template colors and syntax-highlighting token colors.

## Keeping profile.ps1 and profile.zsh in parallel

The two profile scripts are intentionally structured as mirrors of each other (same install-if-missing pattern, same palette-key-to-token mapping). When changing highlighting behavior or the install logic in one, make the equivalent change in the other unless the change is genuinely shell-specific.
