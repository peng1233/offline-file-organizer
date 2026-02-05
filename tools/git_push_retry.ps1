param(
  [string]$Remote = "origin",
  [string]$Branch = "main",
  [int]$Attempts = 6,
  [int]$BaseSleepSeconds = 5
)

$ErrorActionPreference = 'Stop'

# Avoid mojibake in CI/log capture: do not rely on localized Warning/Error streams.
# Keep output ASCII and emit via Write-Host.
try {
  [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
} catch {}
$OutputEncoding = [System.Text.UTF8Encoding]::new($false)

function Set-GitHttpTuning {
  # Repo-local tuning to reduce flaky HTTP/2 behavior and tolerate slow links.
  git config http.version HTTP/1.1 | Out-Null
  git config http.postBuffer 524288000 | Out-Null
  git config http.lowSpeedLimit 0 | Out-Null
  git config http.lowSpeedTime 999999 | Out-Null
}

function Invoke-GitPushOnce {
  param([string]$Remote, [string]$Branch)
  Write-Host ("[git_push_retry] pushing {0} {1} ..." -f $Remote, $Branch)
  & git push $Remote $Branch
  if ($LASTEXITCODE -ne 0) {
    throw ("git push failed with exit code {0}" -f $LASTEXITCODE)
  }
}

Set-GitHttpTuning

for ($i = 1; $i -le $Attempts; $i++) {
  try {
    Invoke-GitPushOnce -Remote $Remote -Branch $Branch
    Write-Host "[git_push_retry] OK"
    exit 0
  } catch {
    $msg = $_.Exception.Message
    Write-Host ("[git_push_retry] WARN failed attempt {0}/{1}: {2}" -f $i, $Attempts, $msg)

    if ($i -eq $Attempts) { break }

    $sleep = [Math]::Min(120, $BaseSleepSeconds * [Math]::Pow(2, ($i - 1)))
    Write-Host ("[git_push_retry] sleep {0}s then retry..." -f $sleep)
    Start-Sleep -Seconds $sleep
  }
}

Write-Host "[git_push_retry] FAIL: push failed after all attempts. Retry later or switch network/VPN."
exit 1