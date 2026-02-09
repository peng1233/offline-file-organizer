# Offline File Organizer (Lite) - one-click open script
# Usage:
#   powershell -NoProfile -ExecutionPolicy Bypass -File .\open.ps1
#   powershell -NoProfile -ExecutionPolicy Bypass -File .\open.ps1 -Path .\index.html
#
# Notes:
# - This script does NOT upload anything. It only opens a local HTML file in your default browser.

param(
  [string]$Path = ".\\index.html"
)

$ErrorActionPreference = 'Stop'

# Resolve to absolute path
$resolved = Resolve-Path -LiteralPath $Path
$fullPath = $resolved.Path

if (-not (Test-Path -LiteralPath $fullPath)) {
  throw "Not found: $fullPath"
}

Write-Host "Opening: $fullPath" -ForegroundColor Cyan
Start-Process -FilePath $fullPath
