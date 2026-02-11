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

Write-Host '\n=== Marketplace assets-index placeholder check ([FILL] / TBD_UI) ==='
$assetsIndex = Join-Path $repoRoot 'docs\marketplace\assets-index_EN.md'
if (Test-Path -LiteralPath $assetsIndex -PathType Leaf) {
  $patterns = @(
    @{ Name = '[FILL]'; Pattern = '\[FILL\]' },
    @{ Name = 'TBD_UI'; Pattern = '\bTBD_UI\b' }
  )

  $any = $false
  foreach ($p in $patterns) {
    $hits = Select-String -LiteralPath $assetsIndex -Pattern $p.Pattern -AllMatches
    if ($hits) {
      $any = $true
      Write-Host ('WARN: Found ' + $p.Name + ' placeholders in: ' + $assetsIndex)
      $total = $hits.Count
      $hits | Select-Object -First 20 | ForEach-Object {
        Write-Host ('  line ' + $_.LineNumber + ': ' + $_.Line.Trim())
      }
      if ($total -gt 20) {
        Write-Host ('  ... (' + ($total - 20) + ' more)')
      }
    }
  }

  if ($any) {
    Write-Host 'WARN: preflight continues; resolve placeholders before final platform copy/paste.'
    Write-Host 'TIP: Generate a full placeholder checklist (saved to docs/marketplace/tbd-ui-report_EN.md):'
    Write-Host '  powershell -NoProfile -File scripts/marketplace-tbd-ui-report.ps1'
  } else {
    Write-Host 'OK: assets-index_EN.md contains no placeholder markers'
  }
} else {
  Write-Host ('WARN: missing file (skip check): ' + $assetsIndex)
}


Write-Host '\n=== Marketplace docs placeholder scan (docs/marketplace/*.md) ==='
$marketplaceRoot = Join-Path $repoRoot 'docs\marketplace'
if (Test-Path -LiteralPath $marketplaceRoot -PathType Container) {
  $mdFiles = Get-ChildItem -LiteralPath $marketplaceRoot -File -Filter '*.md' | Select-Object -ExpandProperty FullName
  $patterns2 = @(
    @{ Name = '[FILL]'; Pattern = '\[FILL\]' },
    @{ Name = 'TBD_UI'; Pattern = '\bTBD_UI\b' }
  )

  foreach ($p in $patterns2) {
    $hits = Select-String -LiteralPath $mdFiles -Pattern $p.Pattern
    $count = if ($hits) { $hits.Count } else { 0 }
    if ($count -gt 0) {
      Write-Host ('WARN: Found ' + $count + ' occurrence(s) of ' + $p.Name + ' across docs/marketplace/*.md')
      $hits | Select-Object -First 12 | ForEach-Object {
        $rel = $_.Path
        try { $rel = Resolve-Path -LiteralPath $_.Path -Relative } catch {}
        Write-Host ('  ' + $rel + ':' + $_.LineNumber + ' ' + $_.Line.Trim())
      }
      if ($count -gt 12) {
        Write-Host ('  ... (' + ($count - 12) + ' more)')
      }
    } else {
      Write-Host ('OK: no ' + $p.Name + ' placeholders found in docs/marketplace/*.md')
    }
  }
} else {
  Write-Host ('WARN: missing folder: ' + $marketplaceRoot)
}


Write-Host '\n=== Docs naming consistency check (docs/marketplace) ==='
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
