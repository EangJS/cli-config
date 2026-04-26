Invoke-Expression (&starship init powershell)

# Run Install-Module PSFzf -Scope CurrentUser first for fzf keybindings
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t'
