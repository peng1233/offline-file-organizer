param(
  [string]$Remote = "origin",
  [string]$Branch = "main",
  [int]$Attempts = 6,
  [int]$BaseSleepSeconds = 5,
  [switch]$CheckOnly,
  [switch]$StopIfNoConnectivity
)

$ErrorActionPreference = 'Stop'

# NOTE (2026-02): This file is kept for backward compatibility.
# The maintained implementation lives in: scripts/git-push-retry.ps1
# We forward parameters so existing docs/automation keep working.

try { [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false) } catch {}

$script = Join-Path $PSScriptRoot '..\scripts\git-push-retry.ps1'
$script = (Resolve-Path -LiteralPath $script).Path

if (-not (Test-Path -LiteralPath $script)) {
  Write-Host "FAIL: scripts/git-push-retry.ps1 not found. Repo may be incomplete."
  exit 1
}

# Map legacy params -> new params
$maxAttempts = $Attempts
$delaySeconds = $BaseSleepSeconds

$argv = @(
  '-NoProfile',
  '-ExecutionPolicy', 'Bypass',
  '-File', $script,
  '-Remote', $Remote,
  '-Branch', $Branch,
  '-MaxAttempts', $maxAttempts,
  '-DelaySeconds', $delaySeconds,
  '-ForceHttp11',
  '-ExponentialBackoff'
)

if ($CheckOnly) { $argv += '-CheckOnly' }
if ($StopIfNoConnectivity) { $argv += '-StopIfNoConnectivity' }

Write-Host "[git_push_retry] Forwarding to scripts/git-push-retry.ps1 (deprecated wrapper)"
& powershell @argv
exit $LASTEXITCODE
