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
} else {
  Write-Host '\n(Skipped) Python scan'
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
