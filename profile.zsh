# oh-my-style — Zsh-Profil-Snippet
#
# Diese Zeilen in dein ~/.zshrc einfügen, um oh-my-style als Prompt-Theme
# zu laden und die Kommandozeilen-Syntax-Highlighting-Farben ans
# Theme anzupassen. Pfad ggf. anpassen.

if ! command -v oh-my-posh &> /dev/null; then
    brew install jandedobbeleer/oh-my-posh/oh-my-posh
fi

OH_MY_STYLE_DIR="${0:A:h}"
OH_MY_STYLE_CONFIG="$OH_MY_STYLE_DIR/oh-my-style.json"
eval "$(oh-my-posh init zsh --config "$OH_MY_STYLE_CONFIG")"

# zsh-syntax-highlighting an die Palette aus oh-my-style.json anpassen.
# Ohne dies faerbt das Plugin unbekannte/erkannte Argumente wie Pfade
# (z.B. "./PSmacOS/") nur mit Unterstreichung in der Standardfarbe Weiss ein,
# was nicht zum Theme passt. Alle Farbwerte kommen ausschliesslich aus der
# "palette" in oh-my-style.json.
ZSH_HIGHLIGHT_DIR="$(brew --prefix zsh-syntax-highlighting 2>/dev/null)"
if [[ -z "$ZSH_HIGHLIGHT_DIR" ]]; then
    brew install zsh-syntax-highlighting
    ZSH_HIGHLIGHT_DIR="$(brew --prefix zsh-syntax-highlighting)"
fi

# Liest einen Wert aus der "palette" in oh-my-style.json (ohne jq/python-Abhaengigkeit).
_oh_my_style_color() {
    sed -n '/"palette"/,/}/p' "$OH_MY_STYLE_CONFIG" \
        | grep -m1 "\"$1\":" \
        | sed -E 's/.*"'"$1"'": *"([^"]+)".*/\1/'
}

typeset -gA ZSH_HIGHLIGHT_STYLES
local c_accent="$(_oh_my_style_color accent)"
local c_parameter="$(_oh_my_style_color parameter)"
local c_muted="$(_oh_my_style_color muted)"
local c_warn="$(_oh_my_style_color warn)"
local c_string="$(_oh_my_style_color string)"
local c_danger="$(_oh_my_style_color danger)"

ZSH_HIGHLIGHT_STYLES[command]="fg=$c_accent"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=$c_accent"
ZSH_HIGHLIGHT_STYLES[function]="fg=$c_accent"
ZSH_HIGHLIGHT_STYLES[alias]="fg=$c_accent"
ZSH_HIGHLIGHT_STYLES[path]="fg=$c_parameter"
ZSH_HIGHLIGHT_STYLES[path_prefix]="fg=$c_parameter"
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=$c_parameter"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=$c_parameter"
ZSH_HIGHLIGHT_STYLES[globbing]="fg=$c_warn"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=$c_string"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=$c_string"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="fg=$c_string"
ZSH_HIGHLIGHT_STYLES[comment]="fg=$c_muted"
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=$c_danger"

unfunction _oh_my_style_color

source "$ZSH_HIGHLIGHT_DIR/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
