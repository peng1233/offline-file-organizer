param(
  [int]$MaxAttempts = 5,
  [int]$DelaySeconds = 15,
  [string]$Remote = 'origin',
  [string]$Branch = '',
  [switch]$CheckOnly,
  [switch]$StopIfNoConnectivity
)

$ErrorActionPreference = 'Stop'

# Force UTF-8 console output to reduce mojibake in PowerShell 5.1 hosts
try { [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false) } catch {}

function Get-GitRemoteUrl {
  param([string]$Remote)

  try {
    $url = (git remote get-url $Remote 2>$null)
    return $url
  } catch {
    return ''
  }
}

function Test-GitHub443 {
  try {
    $r = Test-NetConnection -ComputerName 'github.com' -Port 443 -WarningAction SilentlyContinue
    return [bool]$r.TcpTestSucceeded
  } catch {
    return $false
  }
}

function Invoke-GitPushOnce {
  param([string]$Remote, [string]$Branch)

  if ([string]::IsNullOrWhiteSpace($Branch)) {
    git push $Remote
  } else {
    git push $Remote $Branch
  }

  return $LASTEXITCODE
}

$remoteUrl = Get-GitRemoteUrl -Remote $Remote
Write-Host "[git-push-retry] Starting (remote=$Remote, url=$remoteUrl, branch=$Branch, maxAttempts=$MaxAttempts, delaySeconds=$DelaySeconds, checkOnly=$($CheckOnly.IsPresent))"

$ok443 = Test-GitHub443
if (-not $ok443) {
  Write-Host "WARN: [git-push-retry] Preflight: github.com:443 is NOT reachable right now (Test-NetConnection failed)."
  Write-Host "WARN: [git-push-retry] If you're on an unstable network/proxy, push may keep failing with reset/empty reply."
  if ($StopIfNoConnectivity) {
    Write-Host "FAIL: [git-push-retry] StopIfNoConnectivity is set; aborting before any git push."
    exit 2
  }
} else {
  Write-Host "[git-push-retry] Preflight: github.com:443 reachable."
}

if ($CheckOnly) {
  Write-Host "[git-push-retry] CheckOnly: done."
  exit 0
}

for ($i = 1; $i -le $MaxAttempts; $i++) {
  Write-Host "[git-push-retry] Attempt $i / $MaxAttempts ..."

  try {
    $code = Invoke-GitPushOnce -Remote $Remote -Branch $Branch
  } catch {
    Write-Host "WARN: [git-push-retry] git push threw: $($_.Exception.Message)"
    $code = 1
  }

  if ($code -eq 0) {
    Write-Host "[git-push-retry] Push OK"
    exit 0
  }

  if ($i -lt $MaxAttempts) {
    Write-Host "WARN: [git-push-retry] Push failed (exit=$code). Waiting $DelaySeconds seconds before retry..."
    Start-Sleep -Seconds $DelaySeconds
  }
}

Write-Host "FAIL: [git-push-retry] Push still failing after $MaxAttempts attempts. Possible causes: unstable network / GitHub HTTPS reset / proxy issues. Try again later or switch network."
exit 1
