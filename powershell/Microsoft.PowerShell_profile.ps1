#oh-my-posh init pwsh --config ~/.config/oh-my-posh/rose-pine.omp.json | Invoke-Expression
$ENV:STARSHIP_CONFIG = "$HOME\.config\starship\starship.toml"
Invoke-Expression (& 'C:\Program Files\starship\bin\starship.exe' init powershell --print-full-init | Out-String)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Set-Alias -Name wget -Value "C:\Users\chris\OneDrive\Documents\WindowsPowerShell\Scripts\wget.ps1"

# Replace ls (Get-ChildItem) with Eza
Remove-Item alias:ls -Force
Set-Alias -Name ls -Value "eza"

# Replace cd (Set-Location) with zoxide
Remove-Item alias:cd -Force
Set-Alias -Name cd -Value "z"
