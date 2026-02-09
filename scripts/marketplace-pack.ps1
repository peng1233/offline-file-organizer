param(
  [string]$OutPath = "",
  [switch]$KeepTemp
)

$ErrorActionPreference = 'Stop'

function Ensure-Dir([string]$p) {
  if (-not (Test-Path -LiteralPath $p)) {
    New-Item -ItemType Directory -Path $p | Out-Null
  }
}

$repoRoot = Split-Path -Parent $PSScriptRoot
$timestamp = (Get-Date).ToString('yyyyMMdd_HHmmss')

if ([string]::IsNullOrWhiteSpace($OutPath)) {
  $dist = Join-Path $repoRoot 'dist'
  Ensure-Dir $dist
  $OutPath = Join-Path $dist ("marketplace-pack_{0}.zip" -f $timestamp)
} else {
  $outDir = Split-Path -Parent $OutPath
  if (-not [string]::IsNullOrWhiteSpace($outDir)) { Ensure-Dir $outDir }
}

$stage = Join-Path $env:TEMP ("ofo_marketplace_pack_{0}" -f ([guid]::NewGuid().ToString('N')))
Ensure-Dir $stage

try {
  $marketplaceDir = Join-Path $repoRoot 'docs\marketplace'
  $assetsDir = Join-Path $repoRoot 'docs\assets'

  if (-not (Test-Path -LiteralPath $marketplaceDir)) { throw "Missing folder: $marketplaceDir" }
  if (-not (Test-Path -LiteralPath $assetsDir)) { throw "Missing folder: $assetsDir" }

  # 1) Marketplace texts
  Copy-Item -LiteralPath $marketplaceDir -Destination (Join-Path $stage 'marketplace') -Recurse -Force

  # 2) Demo assets that are commonly needed on platforms
  $stageAssets = Join-Path $stage 'assets'
  Ensure-Dir $stageAssets

  $assetNames = @(
    'lite-demo.gif',
    'lite-demo.png',
    'lite-demo-real.png',
    'tc-donation-v1.png'
  )

  foreach ($n in $assetNames) {
    $src = Join-Path $assetsDir $n
    if (Test-Path -LiteralPath $src) {
      Copy-Item -LiteralPath $src -Destination (Join-Path $stageAssets $n) -Force
    }
  }

  # 3) How to use
  $readme = @()
  $readme += "Offline File Organizer - Marketplace Pack"
  $readme += "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') (GMT+8 local)"
  $readme += ""
  $readme += "Contains:"
  $readme += "- marketplace/  (copy/paste-ready text templates + checklists)"
  $readme += "- assets/       (demo GIF/PNG and donation QR if present)"
  $readme += ""
  $readme += "Tip: Run repo preflight before publishing: scripts/marketplace-preflight.ps1"
  $readmePath = Join-Path $stage 'README.txt'
  [IO.File]::WriteAllText($readmePath, ($readme -join "`r`n"), (New-Object System.Text.UTF8Encoding($false)))

  if (Test-Path -LiteralPath $OutPath) { Remove-Item -LiteralPath $OutPath -Force }

  Compress-Archive -Path (Join-Path $stage '*') -DestinationPath $OutPath -Force

  Write-Host "PACK_OK" -ForegroundColor Green
  Write-Host "OutPath: $OutPath"
  Write-Host "Size: $([Math]::Round((Get-Item -LiteralPath $OutPath).Length / 1KB, 1)) KB"
} finally {
  if (-not $KeepTemp) {
    if (Test-Path -LiteralPath $stage) {
      Remove-Item -LiteralPath $stage -Recurse -Force
    }
  } else {
    Write-Host "TempStage: $stage"
  }
}
