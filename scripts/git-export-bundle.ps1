param(
  [string]$RepoDir = (Split-Path -Parent $PSScriptRoot),
  [string]$OutDir = "bundles",
  [string]$BaseRef = "origin/main",
  [switch]$IncludeTags
)

$ErrorActionPreference = "Stop"

function Write-Info([string]$msg){
  Write-Host ("[git-export-bundle] " + $msg)
}

if(-not (Test-Path -LiteralPath $RepoDir)){
  throw "RepoDir not found: $RepoDir"
}

Push-Location -LiteralPath $RepoDir
try {
  if(-not (Test-Path -LiteralPath ".git")){
    throw "Not a git repository: $RepoDir"
  }

  $stamp = (Get-Date).ToString("yyyyMMdd-HHmmss")
  $outFull = Join-Path $RepoDir $OutDir
  New-Item -ItemType Directory -Force -Path $outFull | Out-Null

  # Ensure BaseRef exists; if not, fallback to current HEAD~1 base (bundle still works but will be larger)
  $baseExists = $true
  try { git rev-parse --verify $BaseRef 1>$null 2>$null } catch { $baseExists = $false }

  if($baseExists){
    $range = "$BaseRef..HEAD"
    $bundlePath = Join-Path $outFull ("push-{0}-from-{1}.bundle" -f $stamp, ($BaseRef -replace '[^a-zA-Z0-9._-]','_'))
    Write-Info "Creating bundle for range: $range"
    git bundle create "$bundlePath" $range | Out-Null
  } else {
    $bundlePath = Join-Path $outFull ("push-{0}-from-HEAD.bundle" -f $stamp)
    Write-Info "WARNING: BaseRef '$BaseRef' not found. Creating bundle containing HEAD only (may be incomplete for push)."
    git bundle create "$bundlePath" HEAD | Out-Null
  }

  if($IncludeTags){
    Write-Info "Including tags (additional bundle)"
    $tagsPath = Join-Path $outFull ("tags-{0}.bundle" -f $stamp)
    git bundle create "$tagsPath" --tags | Out-Null
  }

  Write-Info "Verifying bundle: $bundlePath"
  git bundle verify "$bundlePath"

  Write-Info "OK. Bundle created: $bundlePath"
  Write-Info "Tip: to import elsewhere: git fetch <bundlePath> main"
}
finally {
  Pop-Location
}
