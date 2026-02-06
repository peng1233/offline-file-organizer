#requires -Version 5.1
<#
  build-lite-release.ps1
  Purpose: Convenience wrapper to build the Lite distributable zip from repo root.

  - Calls: .\lite\build-release.ps1
  - Output: .\lite\dist\offline-file-organizer-lite.zip + RELEASE.txt

  Safe/rollback: only writes into ./lite/dist (delegated to lite/build-release.ps1)
#>

$ErrorActionPreference = 'Stop'

function Write-Info($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $root
Set-Location $repoRoot

$script = Join-Path $repoRoot 'lite\build-release.ps1'
if (!(Test-Path $script)) { throw "Missing: $script" }

Write-Info "Building Lite release zip ..."
powershell -NoProfile -ExecutionPolicy Bypass -File $script

Write-Info "Done."
Write-Host "  Zip: lite\\dist\\offline-file-organizer-lite.zip"
Write-Host "  Manifest: lite\\dist\\RELEASE.txt"
