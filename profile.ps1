# oh-my-style — PowerShell-Profil-Snippet
#
# Diese Zeilen in dein PowerShell-Profil ($PROFILE) einfügen, um oh-my-style
# als Prompt-Theme zu laden. Pfad ggf. anpassen.

if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    winget install JanDeDobbeleer.OhMyPosh -s winget
}

$ohMyStyleConfig = Join-Path $PSScriptRoot "oh-my-style.json"
oh-my-posh init pwsh --config $ohMyStyleConfig | Invoke-Expression

# PSReadLine-Syntax-Highlighting an die Palette aus oh-my-style.json anpassen.
# Ohne dies faerbt PSReadLine unbekannte Argumente/Strings (z.B. Pfade wie
# "./PSmacOS/") mit der Standardfarbe Weiss ein, was nicht zum Theme passt.
# Alle Farbwerte kommen ausschliesslich aus der "palette" in oh-my-style.json.
if (Get-Module -ListAvailable -Name PSReadLine) {
    $ohMyStylePalette = (Get-Content $ohMyStyleConfig -Raw | ConvertFrom-Json).palette
    Set-PSReadLineOption -Colors @{
        Command   = $ohMyStylePalette.accent
        Parameter = $ohMyStylePalette.parameter
        Operator  = $ohMyStylePalette.muted
        Variable  = $ohMyStylePalette.variable
        String    = $ohMyStylePalette.string
        Number    = $ohMyStylePalette.number
        Type      = $ohMyStylePalette.warn
        Comment   = $ohMyStylePalette.muted
        Keyword   = $ohMyStylePalette.accent
        Member    = $ohMyStylePalette.fg
    }
}
