# oh-my-style

Ein minimalistisches [Oh My Posh](https://ohmyposh.dev/) Theme im [Nord](https://www.nordtheme.com/)-Farbschema — aufgeräumt, informativ und schnell.

## Vorschau

```
╭─  ~/…/oh-my-style  main ✓
╰─❯
```

- **OS-Icon** – zeigt dein Betriebssystem (inkl. WSL-Hinweis) als Diamond-Segment
- **Pfad** – verkürzter Pfad im Agnoster-Stil, maximal 3 Ebenen tief
- **Git-Status** – Branch, Ahead/Behind, Staging- und Working-Änderungen sowie Stash-Anzahl, farblich hervorgehoben je nach Zustand
- **Ausführungszeit** – rechtsbündig, erscheint ab 500ms Laufzeit
- **Shell-Name** – rechtsbündig neben der Ausführungszeit
- **Zweite Zeile** – schlanker Prompt-Pfeil, der bei Fehlern (Exit-Code > 0) rot aufleuchtet

## Farbpalette

| Name      | Hex       | Verwendung                          |
|-----------|-----------|--------------------------------------|
| `bg`      | `#2E3440` | Hintergrund OS-Segment               |
| `bg_light`| `#3B4252` | Hintergrund Pfad-Segment             |
| `fg`      | `#ECEFF4` | Standard-Vordergrundfarbe            |
| `muted`   | `#4C566A` | Neutraler Git-/Meta-Hintergrund      |
| `accent`  | `#88C0D0` | Prompt-Pfeil, Akzentfarbe            |
| `warn`    | `#EBCB8B` | Ungespeicherte/staged Änderungen     |
| `danger`  | `#BF616A` | Fehler, Ahead/Behind, Exit-Code > 0  |

## Installation

1. Oh My Posh installieren (falls noch nicht geschehen):

   ```bash
   # macOS
   brew install jandedobbeleer/oh-my-posh/oh-my-posh

   # Windows (winget)
   winget install JanDeDobbeleer.OhMyPosh -s winget

   # Linux
   curl -s https://ohmyposh.dev/install.sh | bash -s
   ```

2. Dieses Theme in dein Shell-Profil einbinden:

   ```bash
   # Bash/Zsh (~/.bashrc oder ~/.zshrc)
   eval "$(oh-my-posh init bash --config /pfad/zu/oh-my-style.json)"
   eval "$(oh-my-posh init zsh --config /pfad/zu/oh-my-style.json)"
   ```

   ```powershell
   # PowerShell ($PROFILE)
   oh-my-posh init pwsh --config /pfad/zu/oh-my-style.json | Invoke-Expression
   ```

3. Terminal neu starten (oder Profil neu laden) und ein [Nerd Font](https://www.nerdfonts.com/) aktivieren, damit Icons und Symbole korrekt angezeigt werden.

## Anpassung

Alle Farben sind zentral in der `palette` definiert — ändere sie an einer Stelle, und das gesamte Theme passt sich an. Die Struktur folgt dem offiziellen [Oh My Posh Schema](https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json), das auch von Editoren zur Validierung genutzt werden kann.

## Lizenz

Frei nutzbar und anpassbar.
