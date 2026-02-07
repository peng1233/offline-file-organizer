param(
  [string]$Remote = "origin",
  [string]$Branch = "main",
  [switch]$ForceHttp11,
  [switch]$ExponentialBackoff,
  [switch]$SkipPush,
  [string]$RepoWebUrl = "https://github.com/peng1233/offline-file-organizer"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-Info([string]$s) { Write-Host $s }
function Write-Warn([string]$s) { Write-Host $s -ForegroundColor Yellow }

$whitelistPrefixes = @(
  "docs/",
  "docs/assets/",
  "scripts/"
)
$whitelistExact = @(
  "README.md",
  "README_EN.md"
)

function In-Whitelist([string]$path) {
  if ($whitelistExact -contains $path) { return $true }
  foreach ($p in $whitelistPrefixes) {
    if ($path.StartsWith($p)) { return $true }
  }
  return $false
}

# 1) Try normal push (preferred)
if (-not $SkipPush) {
  $pushArgs = @()
  if ($ForceHttp11) { $pushArgs += "-ForceHttp11" }
  if ($ExponentialBackoff) { $pushArgs += "-ExponentialBackoff" }

  Write-Info "[1/2] Try git push (retry script)..."
  try {
    & "$PSScriptRoot\git-push-retry.ps1" @pushArgs
    Write-Info "OK: git push succeeded."
    exit 0
  } catch {
    Write-Warn "WARN: git push failed. Will print Chrome-web fallback instructions."
  }
} else {
  Write-Warn "SkipPush enabled: not attempting git push."
}

# 2) Fallback guidance (Chrome web)
Write-Info ""
Write-Info "[2/2] Chrome Web Fallback (safe whitelist only)"
Write-Info "Guide: $RepoWebUrl/blob/main/scripts/git-push-fallback-via-chrome.md"
Write-Info ""

$head = (git rev-parse HEAD).Trim()
if (-not $head) { throw "Unable to resolve HEAD commit." }

# List files touched by the last commit
$files = (git show --name-only --pretty=format: $head) | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }

if (-not $files -or $files.Count -eq 0) {
  Write-Warn "No files detected in last commit. You can open the repo and check local changes: git status -sb"
} else {
  Write-Info "Last commit: $head"
  Write-Info "Files in last commit:"
  foreach ($f in $files) {
    $ok = In-Whitelist $f
    if ($ok) {
      Write-Host "  - $f" -ForegroundColor Green
    } else {
      Write-Host "  - $f  (NOT in whitelist)" -ForegroundColor Red
    }
  }

  $nonWhite = @($files | Where-Object { -not (In-Whitelist $_) })
  if ($nonWhite.Count -gt 0) {
    Write-Warn "\nSTOP: last commit contains NON-whitelisted paths. Do NOT use Chrome-web fallback for these files."
    Write-Warn "Suggested: wait for network recovery and push normally, or export a git bundle for backup."
  } else {
    Write-Info "\nAll touched files are whitelisted. You can use Chrome to submit them via the GitHub web UI."
    Write-Info "Open commit diff (copy/paste source): $RepoWebUrl/commit/$head"
    try {
      Start-Process "$RepoWebUrl/commit/$head" | Out-Null
    } catch {
      # ignore
    }
  }
}

Write-Info "\nLocal follow-up after web submit:"
Write-Info "  git fetch --prune"
Write-Info "  git status -sb"
Write-Info "If you see divergence, align to origin/main ONLY after confirming the web commit contains your changes."

exit 1
