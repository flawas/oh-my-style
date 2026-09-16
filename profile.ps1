# oh-my-style — PowerShell-Profil-Snippet
#
# Diese Zeilen in dein PowerShell-Profil ($PROFILE) einfügen, um oh-my-style
# als Prompt-Theme zu laden. Pfad ggf. anpassen.

if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    winget install JanDeDobbeleer.OhMyPosh -s winget
}

$ohMyStyleConfig = Join-Path $PSScriptRoot "oh-my-style.json"
oh-my-posh init pwsh --config $ohMyStyleConfig | Invoke-Expression
