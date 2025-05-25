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

# Run Helix from WSL instead of Windows.
# This is because most of my development will be through WSL.
function global:hx {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Paths
    )

    # If no arguments are provided, just run hx in WSL with .bashrc loaded
    if ($Paths.Count -eq 0) {
        wsl bash -ic 'hx'
        return
    }

    # Convert each path to WSL format
    $wslPaths = @()
    foreach ($path in $Paths) {
        # Handle relative paths by converting them to full paths first
        $fullPath = (Resolve-Path $path -ErrorAction SilentlyContinue).Path
        if (-not $fullPath) {
            # If path doesn't exist (might be a new file), use it as-is but convert to full path
            $fullPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
        }

        # Convert Windows path to WSL path
        if ($fullPath -match '^([A-Za-z]):\\') {
            $driveLetter = $Matches[1].ToLower()
            $unixPath = $fullPath -replace '^[A-Za-z]:\\', "/mnt/$driveLetter/"
            $unixPath = $unixPath -replace '\\', '/'
            $wslPaths += $unixPath
        } elseif ($fullPath -match '^\\\\') {
            # Handle UNC paths (network shares)
            Write-Warning "UNC paths (network shares) may not work properly with WSL"
            $unixPath = $fullPath -replace '^\\\\', "/mnt/"
            $unixPath = $unixPath -replace '\\', '/'
            $wslPaths += $unixPath
        } else {
            # If it's already a Unix-style path or relative path, pass it through
            $wslPaths += $path
        }
    }

    # Escape single quotes in paths and join them with spaces
    $escapedPaths = ($wslPaths -replace "'", "'\''") -join ' '

    # Run hx in WSL with .bashrc loaded and the converted paths
    if ($wslPaths.Count -gt 0) {
        wsl bash -ic "hx '$escapedPaths'"
    }
}
