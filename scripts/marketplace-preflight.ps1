param(
  [switch]$SkipNode,
  [switch]$SkipPython
)

$ErrorActionPreference = 'Stop'

try {
  [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding($false)
} catch {}

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $repoRoot

function RunStep([string]$label, [string]$cmd) {
  Write-Host ('\n=== ' + $label + ' ===')
  Write-Host $cmd
  Invoke-Expression $cmd
  if ($LASTEXITCODE -ne 0) {
    throw ('Step failed (exit=' + $LASTEXITCODE + '): ' + $label)
  }
}

Write-Host 'Marketplace preflight: basic self-check + text safety scan'
Write-Host ('Repo: ' + $repoRoot)

if (-not $SkipNode) {
  RunStep -label 'Node self-check (main)' -cmd 'node .\tools\self_check.js'
  RunStep -label 'Node self-check (lite)' -cmd 'node .\lite\selfcheck.js'
} else {
  Write-Host '\n(Skipped) Node self-check'
}

if (-not $SkipPython) {
  RunStep -label 'Scan key publish assets for replacement char (U+FFFD)' -cmd 'python .\scripts\check_no_replacement_char.py --paths docs\marketplace README.md README_EN.md index.html en.html'
  RunStep -label 'Scan English copy templates for paste-breaking chars (warn on smart quotes, fail on U+FFFD/NBSP/ZWSP)' -cmd 'python .\scripts\check_ascii_only.py --glob "docs/marketplace/*_EN*.md" "docs/marketplace/*copy_EN.md" "docs/marketplace/*template_EN.md" --paths README_EN.md en.html'
} else {
  Write-Host '\n(Skipped) Python scan'
}

Write-Host '\n=== Marketplace assets-index [FILL] placeholder check ==='
$assetsIndex = Join-Path $repoRoot 'docs\marketplace\assets-index_EN.md'
if (Test-Path -LiteralPath $assetsIndex -PathType Leaf) {
  $hits = Select-String -LiteralPath $assetsIndex -Pattern '\[FILL\]' -AllMatches
  if ($hits) {
    Write-Host ('WARN: Found [FILL] placeholders in: ' + $assetsIndex)
    foreach ($h in $hits) {
      Write-Host ('  line ' + $h.LineNumber + ': ' + $h.Line.Trim())
    }
    Write-Host 'WARN: preflight continues; fill these before final platform copy/paste.'
  } else {
    Write-Host 'OK: assets-index_EN.md contains no [FILL] placeholders'
  }
} else {
  Write-Host ('WARN: missing file (skip check): ' + $assetsIndex)
}

Write-Host '\n=== Docs naming consistency check (docs/marketplace) ==='
$marketplaceRoot = Join-Path $repoRoot 'docs\marketplace'
if (Test-Path -LiteralPath $marketplaceRoot -PathType Container) {
  $files = Get-ChildItem -LiteralPath $marketplaceRoot -File -Filter '*.md' | Select-Object -ExpandProperty Name
  $lowerSet = @{}
  foreach ($f in $files) { $lowerSet[$f.ToLowerInvariant()] = $true }

  $warns = 0
  foreach ($f in $files) {
    $lower = $f.ToLowerInvariant()
    if ($lower.EndsWith('-en.md')) {
      $canon = $f.Substring(0, $f.Length - 6) + '_EN.md'
      if ($lowerSet.ContainsKey($canon.ToLowerInvariant())) {
        Write-Host ("WARN: Found both EN naming variants: '" + $f + "' and '" + $canon + "'. Consider keeping only one to reduce confusion.")
        $warns++
      }
    }
  }

  if ($warns -eq 0) {
    Write-Host 'OK: no obvious duplicate EN naming variants found'
  } else {
    Write-Host ('WARN: total warnings=' + $warns + ' (non-fatal)')
  }
} else {
  Write-Host ('WARN: missing folder: ' + $marketplaceRoot)
}

Write-Host '\n=== Asset presence check ==='
$assetRoot = Join-Path $repoRoot 'docs\assets'
$assets = @('lite-demo.gif','lite-demo.png','lite-demo-real.png')
foreach ($a in $assets) {
  $p = Join-Path $assetRoot $a
  if (Test-Path -LiteralPath $p -PathType Leaf) {
    $len = (Get-Item -LiteralPath $p).Length
    Write-Host ('OK: ' + $a + ' (' + $len + ' bytes)')
  } else {
    throw ('Missing required asset: ' + $p)
  }
}

Write-Host '\nPRECHECK_OK'
