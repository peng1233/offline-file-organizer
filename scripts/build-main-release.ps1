#requires -Version 5.1
<#
  build-main-release.ps1
  Purpose: Create a small offline distributable package for the MAIN (full) demo from repo root.

  - No build step required (static files)
  - Output: .\dist\offline-file-organizer-main.zip
  - Writes: .\dist\RELEASE_MAIN.txt (SHA256 + file list)

  Safe/rollback: only writes into ./dist
#>

$ErrorActionPreference = 'Stop'

function Write-Info($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Write-Warn($msg) { Write-Host "[WARN] $msg" -ForegroundColor Yellow }

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $repoRoot
Set-Location $repoRoot

# Optional preflight (does not modify anything)
$preflight = Join-Path $repoRoot 'scripts\marketplace-preflight.ps1'
if (Test-Path $preflight) {
  Write-Info "Running marketplace preflight (optional) ..."
  try {
    $pfOut = powershell -NoProfile -ExecutionPolicy Bypass -File $preflight 2>&1 | Out-String
  } catch {
    Write-Warn "Preflight failed (continuing build)."
    $pfOut = $pfOut + "`n" + ($_ | Out-String)
  }
} else {
  $pfOut = "(marketplace-preflight.ps1 not found)"
}

# Prepare dist
$dist = Join-Path $repoRoot 'dist'
if (!(Test-Path $dist)) { New-Item -ItemType Directory -Path $dist | Out-Null }

$zipName = 'offline-file-organizer-main.zip'
$zipPath = Join-Path $dist $zipName
if (Test-Path $zipPath) { Remove-Item -Force $zipPath }

# Collect files
# Keep it small: only what an end-user needs to run locally.
$files = @(
  'index.html',
  'en.html',
  'open.cmd',
  'open.ps1',
  'README_EN.md',
  'LICENSE'
)

foreach ($f in $files) {
  if (!(Test-Path (Join-Path $repoRoot $f))) { throw "Missing file: $f" }
}

$assetsDir = Join-Path $repoRoot 'assets'
if (!(Test-Path $assetsDir)) { throw "Missing folder: assets" }

# Zip package
Write-Info "Creating zip: $zipPath"
$tempRoot = Join-Path $env:TEMP ("ofo-main-package-" + [Guid]::NewGuid().ToString('n'))
New-Item -ItemType Directory -Path $tempRoot | Out-Null

try {
  foreach ($f in $files) {
    Copy-Item -LiteralPath (Join-Path $repoRoot $f) -Destination (Join-Path $tempRoot $f) -Force
  }
  Copy-Item -LiteralPath $assetsDir -Destination (Join-Path $tempRoot 'assets') -Recurse -Force

  Compress-Archive -Path (Join-Path $tempRoot '*') -DestinationPath $zipPath -CompressionLevel Optimal
} finally {
  if (Test-Path $tempRoot) { Remove-Item -LiteralPath $tempRoot -Recurse -Force }
}

# Hash + manifest
$hash = (Get-FileHash -Algorithm SHA256 -Path $zipPath).Hash.ToLowerInvariant()
$releaseTxt = Join-Path $dist 'RELEASE_MAIN.txt'

$lines = @()
$lines += "Name: $zipName"
$lines += "SHA256: $hash"
$lines += "BuiltAt: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss K')"
$lines += "Packaged:" 
$lines += "  - assets/ (recursive)"
foreach ($f in $files) { $lines += "  - $f" }
$lines += ""
$lines += "PreflightOutput:"
$lines += ($pfOut.TrimEnd() -split "`r?`n" | ForEach-Object { "  $_" })

# Write UTF-8 with BOM for better Windows readability
$utf8Bom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllLines($releaseTxt, $lines, $utf8Bom)

Write-Info "Done."
Write-Host "  Zip: $zipPath"
Write-Host "  Manifest: $releaseTxt"
