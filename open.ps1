param(
  [switch]$NoOpen,
  [switch]$Lite,
  [switch]$Server,
  [int]$Port = 5173
)

$ErrorActionPreference = 'Stop'

function Fail($msg) {
  Write-Host "FAIL: $msg" -ForegroundColor Red
  exit 1
}

$root = Split-Path -Parent $MyInvocation.MyCommand.Path

# Back-compat: keep old default behavior (open main index.html via file://)
$index = Join-Path $root 'index.html'
$liteIndex = Join-Path $root 'lite\index.html'

if ($Server) {
  $node = Get-Command node -ErrorAction SilentlyContinue
  if (-not $node) {
    Fail 'Node.js not found. Install Node.js (LTS) then run again, or use open.cmd without -Server.'
  }

  $serve = Join-Path $root 'tools\serve.js'
  if (-not (Test-Path -LiteralPath $serve)) {
    Fail "tools/serve.js not found: $serve"
  }

  if (-not ($Port -ge 1 -and $Port -le 65535)) {
    Fail 'Invalid -Port. Use 1-65535.'
  }

  $pathSuffix = if ($Lite) { '/lite/' } else { '/' }
  $urlToOpen = "http://127.0.0.1:$Port$pathSuffix"

  if (-not $NoOpen) {
    Start-Process -FilePath $urlToOpen
  }

  Write-Host "OK: serving on http://127.0.0.1:$Port (Ctrl+C to stop)"
  Write-Host "     open: $urlToOpen"

  # Keep it deterministic: do not auto-open inside serve.js (we already handled it)
  & node $serve --port $Port --no-open
  exit $LASTEXITCODE
}

# file:// mode
$target = if ($Lite) { $liteIndex } else { $index }

if (-not (Test-Path -LiteralPath $target)) {
  Fail "File not found: $target"
}

if ($NoOpen) {
  Write-Host "OK: $target"
  exit 0
}

Start-Process -FilePath $target
Write-Host "OK: opened $target"