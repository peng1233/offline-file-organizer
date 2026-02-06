param(
  [switch]$NoOpen
)

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$index = Join-Path $root 'index.html'

if (-not (Test-Path -LiteralPath $index)) {
  Write-Host "FAIL: index.html not found: $index"
  exit 1
}

if ($NoOpen) {
  Write-Host "OK: $index"
  exit 0
}

Start-Process -FilePath $index
Write-Host "OK: opened $index"
