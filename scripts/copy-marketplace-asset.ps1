param(
  [string]$Name = 'one-pager-short_EN.md',
  [switch]$List
)

$ErrorActionPreference = 'Stop'

try {
  [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding($false)
} catch {}

$root = Split-Path -Parent $PSScriptRoot
$dir = Join-Path $root 'docs\marketplace'

if($List){
  Get-ChildItem -LiteralPath $dir -File -Filter '*.md' | Sort-Object Name | ForEach-Object {
    $_.Name
  }
  exit 0
}

$path = Join-Path $dir $Name
if(-not (Test-Path -LiteralPath $path -PathType Leaf)){
  Write-Host ('Not found: ' + $path)
  Write-Host 'Tip: run with -List to see available files.'
  exit 2
}

$text = Get-Content -LiteralPath $path -Raw
try {
  Set-Clipboard -Value $text
  Write-Host ('Copied to clipboard: ' + $path)
} catch {
  Write-Host ('Clipboard copy failed; printing content instead: ' + $path)
  Write-Output $text
}
