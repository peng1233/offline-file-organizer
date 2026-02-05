param(
  [int]$MaxAttempts = 5,
  [int]$DelaySeconds = 15,
  [string]$Remote = 'origin',
  [string]$Branch = ''
)

$ErrorActionPreference = 'Stop'

function Invoke-GitPushOnce {
  param([string]$Remote, [string]$Branch)

  if ([string]::IsNullOrWhiteSpace($Branch)) {
    git push $Remote
  } else {
    git push $Remote $Branch
  }

  return $LASTEXITCODE
}

Write-Host "[git-push-retry] Starting push (remote=$Remote, branch=$Branch, maxAttempts=$MaxAttempts, delaySeconds=$DelaySeconds)"

for ($i = 1; $i -le $MaxAttempts; $i++) {
  Write-Host "[git-push-retry] Attempt $i / $MaxAttempts ..."

  try {
    $code = Invoke-GitPushOnce -Remote $Remote -Branch $Branch
  } catch {
    Write-Warning "[git-push-retry] git push threw: $($_.Exception.Message)"
    $code = 1
  }

  if ($code -eq 0) {
    Write-Host "[git-push-retry] Push OK"
    exit 0
  }

  if ($i -lt $MaxAttempts) {
    Write-Warning "[git-push-retry] Push failed (exit=$code). Waiting $DelaySeconds seconds before retry..."
    Start-Sleep -Seconds $DelaySeconds
  }
}

Write-Error "[git-push-retry] Push still failing after $MaxAttempts attempts. Possible causes: unstable network / GitHub HTTPS reset / proxy issues. Try again later or switch network."
exit 1
