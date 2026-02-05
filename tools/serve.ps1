param(
  [int]$Port = 5173,
  [switch]$NoOpen
)

$ErrorActionPreference = 'Stop'

# Wrapper for Windows users who prefer PowerShell over typing Node commands.
# Requires Node.js in PATH.

$nodeCmd = Get-Command node -ErrorAction SilentlyContinue
if (-not $nodeCmd) {
  Write-Host 'Node.js was not found in PATH.'
  Write-Host 'Please install Node.js (LTS) and restart your terminal.'
  exit 1
}

$serveJs = Join-Path $PSScriptRoot 'serve.js'
if (-not (Test-Path -LiteralPath $serveJs)) {
  Write-Host ('Missing file: ' + $serveJs)
  exit 1
}

$nodeArgs = @(
  $serveJs,
  '--port',
  $Port
)

if ($NoOpen) {
  $nodeArgs += '--no-open'
}

& node @nodeArgs
