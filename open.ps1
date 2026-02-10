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
  if (-not ($Port -ge 1 -and $Port -le 65535)) {
    Fail 'Invalid -Port. Use 1-65535.'
  }

  $servePs1 = Join-Path $root 'tools\serve.ps1'
  if (-not (Test-Path -LiteralPath $servePs1)) {
    Fail "tools/serve.ps1 not found: $servePs1"
  }

  $pathSuffix = if ($Lite) { '/lite/' } else { '/' }
  $urlToOpen = "http://127.0.0.1:$Port$pathSuffix"

  # If Lite is requested, prevent serve.ps1 from opening the root URL by default.
  $serveNoOpen = $NoOpen -or $Lite

  if (-not $NoOpen) {
    Start-Process -FilePath $urlToOpen
  }

  Write-Host "OK: serving on http://127.0.0.1:$Port (Ctrl+C to stop)"
  Write-Host "     open: $urlToOpen"

  # Delegate to serve.ps1 so it can use Node.js when available, otherwise fall back to Python.
  if ($serveNoOpen) {
    & powershell -NoProfile -ExecutionPolicy Bypass -File $servePs1 -Port $Port -NoOpen
  } else {
    & powershell -NoProfile -ExecutionPolicy Bypass -File $servePs1 -Port $Port
  }

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