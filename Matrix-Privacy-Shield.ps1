<# 
    Matrix Privacy Shield
    Anti Shoulder-Surfing Tool for PowerShell
    Version : 1.0
#>

$global:MatrixEnabled = $true

function Show-MatrixShield {
    param([int]$DurationSec = 1.6)

    $originalTitle = $Host.UI.RawUI.WindowTitle
    $Host.UI.RawUI.WindowTitle = "MATRIX PRIVACY SHIELD"

    $width = [Console]::WindowWidth
    $height = [Console]::WindowHeight
    $chars = "01アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワン".ToCharArray()

    $endTime = (Get-Date).AddSeconds($DurationSec)

    while ((Get-Date) -lt $endTime) {
        for ($x = 0; $x -lt $width; $x++) {
            $char = $chars[(Get-Random -Maximum $chars.Length)]
            $color = switch (Get-Random -Maximum 6) {
                0 { "Green" }
                1 { "DarkGreen" }
                2 { "Cyan" }
                3 { "Magenta" }
                4 { "Yellow" }
                5 { "White" }
            }
            Write-Host -NoNewline -ForegroundColor $color $char
        }
        Start-Sleep -Milliseconds 45
    }

    Clear-Host
    $Host.UI.RawUI.WindowTitle = $originalTitle
}

# Prompt qui déclenche la protection
function prompt {
    if ($global:MatrixEnabled) {
        Show-MatrixShield -DurationSec 1.5
    }
    "PS $($executionContext.SessionState.Path.CurrentLocation)> "
}

# Commandes de contrôle
function Enable-Matrix  { $global:MatrixEnabled = $true;  Write-Host "Matrix Privacy Shield → ACTIVÉ" -ForegroundColor Green }
function Disable-Matrix { $global:MatrixEnabled = $false; Write-Host "Matrix Privacy Shield → DÉSACTIVÉ" -ForegroundColor Red }
function Toggle-Matrix  { 
    $global:MatrixEnabled = -not $global:MatrixEnabled
    if ($global:MatrixEnabled) { Write-Host "Matrix Privacy Shield → ACTIVÉ" -ForegroundColor Green }
    else { Write-Host "Matrix Privacy Shield → DÉSACTIVÉ" -ForegroundColor Red }
}

Write-Host "Matrix Privacy Shield loaded successfully!" -ForegroundColor Cyan
Write-Host "Utilise Toggle-Matrix pour activer/désactiver" -ForegroundColor Gray
