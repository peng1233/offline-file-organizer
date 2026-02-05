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
$full = Resolve-Path -LiteralPath $Path

Write-Host "Opening: $full" -ForegroundColor Cyan
Start-Process $full
