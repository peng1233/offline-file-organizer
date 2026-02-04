#requires -Version 5.1
<#[
  build-release.ps1
  Purpose: Create a small, offline distributable package for offline-file-organizer-lite.
  - Runs selfcheck.js (Node required)
  - Creates dist/offline-file-organizer-lite.zip
  - Writes SHA256 + file list to dist/RELEASE.txt

  Safe/rollback: only writes into ./dist
#>

$ErrorActionPreference = 'Stop'

function Write-Info($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Write-Warn($msg) { Write-Host "[WARN] $msg" -ForegroundColor Yellow }

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

# 1) Self-check
Write-Info "Running self check (node selfcheck.js) ..."
try {
  $out = node .\selfcheck.js 2>&1 | Out-String
} catch {
  Write-Warn "Node is required. Install Node.js LTS, then re-run this script."
  throw
}
if ($out -notmatch 'SELF_CHECK_OK') {
  Write-Host $out
  throw "Self-check failed: expected 'SELF_CHECK_OK'."
}
Write-Info "Self-check OK."

# 2) Prepare dist
$dist = Join-Path $root 'dist'
if (!(Test-Path $dist)) { New-Item -ItemType Directory -Path $dist | Out-Null }

$zipName = 'offline-file-organizer-lite.zip'
$zipPath = Join-Path $dist $zipName
if (Test-Path $zipPath) { Remove-Item -Force $zipPath }

# 3) Zip package
$files = @('index.html','README.md','selfcheck.js','.editorconfig','build-release.ps1')
foreach ($f in $files) {
  if (!(Test-Path (Join-Path $root $f))) { throw "Missing file: $f" }
}

Write-Info "Creating zip: $zipPath"
Compress-Archive -Path ($files | ForEach-Object { Join-Path $root $_ }) -DestinationPath $zipPath -CompressionLevel Optimal

# 4) Hash + manifest
$hash = (Get-FileHash -Algorithm SHA256 -Path $zipPath).Hash.ToLowerInvariant()
$releaseTxt = Join-Path $dist 'RELEASE.txt'

$lines = @()
$lines += "Name: $zipName"
$lines += "SHA256: $hash"
$lines += "BuiltAt: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss K')"
$lines += "Files:"
foreach ($f in $files) { $lines += "  - $f" }
$lines += ""
$lines += "SelfCheckOutput:"
$lines += ($out.TrimEnd() -split "`r?`n" | ForEach-Object { "  $_" })

# Write UTF-8 with BOM for better Windows readability
$utf8Bom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllLines($releaseTxt, $lines, $utf8Bom)

Write-Info "Done."
Write-Host "  Zip: $zipPath"
Write-Host "  Manifest: $releaseTxt"
