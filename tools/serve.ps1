#requires -Version 3
<#
Wrapper launcher for the local static server.

Why:
- Some browser APIs (e.g. File System Access API / showDirectoryPicker)
  require a secure context. http://localhost qualifies; file:// often doesn't.

This script prefers Node.js (tools/serve.js) when available.

Usage:
  powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\serve.ps1
  powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\serve.ps1 -Port 5179 -NoOpen
  powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\serve.ps1 -SelfTest
#>

[CmdletBinding()]
param(
  [int]$Port = 5173,
  [switch]$NoOpen,
  [switch]$SelfTest
)

function Assert-Port([int]$p) {
  if ($p -lt 1 -or $p -gt 65535) {
    throw "Invalid -Port $p (use 1-65535)."
  }
}

function Has-Command([string]$name) {
  return [bool](Get-Command $name -ErrorAction SilentlyContinue)
}

function Open-Url([string]$url) {
  if ($NoOpen) { return }
  try { Start-Process $url | Out-Null } catch { }
}

function Start-NodeServer([int]$p) {
  $args = @('tools/serve.js', "--port=$p")
  if ($NoOpen) { $args += '--no-open' }
  return Start-Process -FilePath 'node' -ArgumentList $args -PassThru -WindowStyle Hidden
}

function SelfTest-Node([int]$p) {
  if (-not (Has-Command 'node')) {
    Write-Host 'SELFTEST_NEED_NODE'
    return 2
  }

  $proc = $null
  try {
    $proc = Start-Process -FilePath 'node' -ArgumentList @('tools/serve.js', "--port=$p", '--no-open') -PassThru -WindowStyle Hidden

    # Wait a moment for the port to listen
    Start-Sleep -Milliseconds 500

    $u1 = "http://127.0.0.1:$p/"
    $u2 = "http://127.0.0.1:$p/lite/"

    $r1 = Invoke-WebRequest -UseBasicParsing -Uri $u1 -TimeoutSec 3
    $r2 = Invoke-WebRequest -UseBasicParsing -Uri $u2 -TimeoutSec 3

    if ($r1.StatusCode -ne 200) { throw "GET / failed: $($r1.StatusCode)" }
    if ($r2.StatusCode -ne 200) { throw "GET /lite/ failed: $($r2.StatusCode)" }

    Write-Host 'SELFTEST_OK'
    return 0
  } catch {
    Write-Host ('SELFTEST_FAIL: ' + $_.Exception.Message)
    return 1
  } finally {
    if ($proc -and -not $proc.HasExited) {
      try { Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue } catch { }
    }
  }
}

Assert-Port $Port

if ($SelfTest) {
  $testPort = $Port
  if ($testPort -eq 5173) { $testPort = 5179 }
  exit (SelfTest-Node $testPort)
}

if (Has-Command 'node') {
  $url = "http://127.0.0.1:$Port/"
  Write-Host ("Serving: " + $url)
  Write-Host ("Lite:    http://127.0.0.1:$Port/lite/")
  Open-Url $url
  # Run in foreground (inherits ctrl+c) by invoking node directly:
  $nodeArgs = @('tools/serve.js', "--port=$Port")
  if ($NoOpen) { $nodeArgs += '--no-open' }
  & node @nodeArgs
  exit $LASTEXITCODE
}

if (Has-Command 'python') {
  $url = "http://127.0.0.1:$Port/"
  Write-Host ("Serving (python): " + $url)
  Write-Host ("Lite:             http://127.0.0.1:$Port/lite/")
  Open-Url $url
  & python -m http.server $Port --bind 127.0.0.1
  exit $LASTEXITCODE
}

Write-Host 'ERROR: Neither node nor python was found in PATH.'
exit 3
