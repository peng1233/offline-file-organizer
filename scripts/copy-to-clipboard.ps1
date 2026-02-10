param(
  [Parameter(Mandatory=$true)]
  [string]$Path
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $Path)) {
  throw "File not found: $Path"
}

# Read as raw text. Most marketplace templates are ASCII/UTF-8 and should paste cleanly.
$text = Get-Content -LiteralPath $Path -Raw

# Prefer Set-Clipboard when available (Windows PowerShell 5.1 on Windows 10+).
if (Get-Command -Name Set-Clipboard -ErrorAction SilentlyContinue) {
  Set-Clipboard -Value $text
} else {
  # Fallback for environments without Set-Clipboard.
  $text | clip.exe
}

$chars = $text.Length
Write-Output "COPIED_OK: $Path ($chars chars)"
