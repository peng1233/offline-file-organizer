<#
.SYNOPSIS
  One-command build for marketplace assets (Main + Lite + Pack + Report).

.DESCRIPTION
  Runs the minimal offline packaging steps in a predictable order on Windows PowerShell 5.1.
  Produces:
    - dist/offline-file-organizer-main.zip + dist/RELEASE_MAIN.txt
    - lite/dist/offline-file-organizer-lite.zip + lite/dist/RELEASE_LITE.txt
    - dist/marketplace-pack_*.zip (optionally includes demo zips)
    - docs/marketplace/assets-sizes_EN.md

  Safe by default: does not require network.

.PARAMETER IncludeDemoZips
  If set, includes the already-built Main/Lite demo zip files into the marketplace pack.

.PARAMETER SkipPreflight
  If set, skips scripts/marketplace-preflight.ps1.
#>

[CmdletBinding()]
param(
  [switch]$IncludeDemoZips,
  [switch]$SkipPreflight
)

$ErrorActionPreference = 'Stop'

function Invoke-Step {
  param(
    [Parameter(Mandatory=$true)][string]$Name,
    [Parameter(Mandatory=$true)][scriptblock]$Script
  )
  Write-Host "==> $Name" -ForegroundColor Cyan
  & $Script
  Write-Host "OK: $Name" -ForegroundColor Green
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Set-Location $repoRoot

try {
  if (-not $SkipPreflight) {
    Invoke-Step -Name 'Marketplace preflight' -Script {
      powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $repoRoot 'scripts\marketplace-preflight.ps1')
    }
  }

  Invoke-Step -Name 'Build Main release zip' -Script {
    powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $repoRoot 'scripts\build-main-release.ps1')
  }

  Invoke-Step -Name 'Build Lite release zip' -Script {
    powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $repoRoot 'scripts\build-lite-release.ps1')
  }

  $packArgs = @('-NoProfile','-ExecutionPolicy','Bypass','-File', (Join-Path $repoRoot 'scripts\marketplace-pack.ps1'))
  if ($IncludeDemoZips) { $packArgs += '-IncludeDemoZips' }

  Invoke-Step -Name 'Build marketplace pack zip' -Script {
    powershell @packArgs
  }

  Invoke-Step -Name 'Generate asset size report' -Script {
    powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $repoRoot 'scripts\marketplace-asset-report.ps1')
  }

  Write-Host 'BUILD_AND_PACK_OK' -ForegroundColor Green
  exit 0
}
catch {
  Write-Host ('BUILD_AND_PACK_FAILED: ' + $_.Exception.Message) -ForegroundColor Red
  exit 1
}
