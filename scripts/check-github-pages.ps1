<#
Check that GitHub Pages URLs are reachable (for quick SEO/publish verification).

PowerShell 5.1 compatible.

Usage:
  powershell -NoProfile -File scripts/check-github-pages.ps1
  powershell -NoProfile -File scripts/check-github-pages.ps1 -BaseUrl "https://<user>.github.io/<repo>"

Exit codes:
  0 = all ok
  2 = at least one URL failed
#>

param(
  [string]$BaseUrl = "https://peng1233.github.io/offline-file-organizer",
  [int]$TimeoutSec = 20
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Normalize-BaseUrl([string]$u) {
  if ([string]::IsNullOrWhiteSpace($u)) { throw "BaseUrl is empty" }
  $u = $u.Trim()
  if ($u.EndsWith('/')) { $u = $u.TrimEnd('/') }
  return $u
}

function Check-Url([string]$url, [string]$expectContains) {
  $result = [ordered]@{ Url=$url; Ok=$false; Status=$null; Bytes=$null; Note=$null }
  try {
    $r = Invoke-WebRequest -Uri $url -UseBasicParsing -Method GET -TimeoutSec $TimeoutSec
    $result.Status = [int]$r.StatusCode

    if ($r.Content -ne $null) {
      $result.Bytes = [int]([Text.Encoding]::UTF8.GetByteCount([string]$r.Content))
    }

    if ($result.Status -ge 200 -and $result.Status -lt 400) {
      if ($expectContains) {
        if (($r.Content -as [string]) -and ($r.Content -like "*$expectContains*")) {
          $result.Ok = $true
        } else {
          $result.Ok = $false
          $result.Note = "Missing expected marker: $expectContains"
        }
      } else {
        $result.Ok = $true
      }
    } else {
      $result.Ok = $false
      $result.Note = "Bad HTTP status"
    }
  } catch {
    $result.Ok = $false
    $result.Note = ($_.Exception.Message)
  }
  return [pscustomobject]$result
}

$BaseUrl = Normalize-BaseUrl $BaseUrl

$checks = @(
  @{ Path = '/'; Expect = '<!doctype html' },
  @{ Path = '/en.html'; Expect = '<!doctype html' },
  @{ Path = '/lite/'; Expect = '<!doctype html' },
  @{ Path = '/robots.txt'; Expect = 'User-agent' },
  @{ Path = '/sitemap.xml'; Expect = '<urlset' }
)

Write-Host ("BASE: {0}" -f $BaseUrl)
Write-Host ("TimeoutSec: {0}" -f $TimeoutSec)
Write-Host ""

$failed = @()
foreach ($c in $checks) {
  $url = $BaseUrl + $c.Path
  $r = Check-Url -url $url -expectContains $c.Expect
  $statusText = if ($r.Status -ne $null) { $r.Status } else { 'ERR' }
  $bytesText = if ($r.Bytes -ne $null) { $r.Bytes } else { '-' }
  $okText = if ($r.Ok) { 'OK ' } else { 'BAD' }

  if ($r.Ok) {
    Write-Host ("[{0}] {1}  status={2} bytes={3}" -f $okText, $r.Url, $statusText, $bytesText)
  } else {
    Write-Host ("[{0}] {1}  status={2} bytes={3}  note={4}" -f $okText, $r.Url, $statusText, $bytesText, $r.Note)
    $failed += $r
  }
}

Write-Host ""
if ($failed.Count -gt 0) {
  Write-Host ("RESULT: FAIL ({0} url(s) failed)" -f $failed.Count)
  exit 2
}

Write-Host "RESULT: OK"
exit 0
