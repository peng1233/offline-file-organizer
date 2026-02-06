<#
.SYNOPSIS
  Diagnose flaky HTTPS connectivity to github.com:443 on Windows/PowerShell.

.DESCRIPTION
  Prints basic environment info and runs a few lightweight probes:
  - DNS resolve
  - TCP connect test to github.com:443
  - HEAD requests to https://github.com and a repo URL

  This script is intentionally dependency-free (PowerShell 5.1 compatible).

.EXAMPLE
  powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\diagnose-github-443.ps1
#>

[CmdletBinding()]
param(
  [int]$TimeoutSeconds = 10
)

$ErrorActionPreference = 'Stop'

function Write-Section([string]$title) {
  Write-Host "" 
  Write-Host ("=" * 72)
  Write-Host $title
  Write-Host ("=" * 72)
}

function Try-Step([string]$name, [scriptblock]$fn) {
  Write-Host "-- $name"
  try {
    & $fn
    Write-Host "OK: $name"
  } catch {
    Write-Host "FAIL: $name"
    Write-Host $_.Exception.Message
    if ($_.Exception.InnerException) {
      Write-Host ("Inner: " + $_.Exception.InnerException.Message)
    }
  }
}

Write-Section "Environment"
Try-Step "PowerShell version" { $PSVersionTable | Format-List | Out-String | Write-Host }
Try-Step "OS" { (Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, BuildNumber) | Format-List | Out-String | Write-Host }
Try-Step "TLS(SecurityProtocol) before" { [Net.ServicePointManager]::SecurityProtocol | Write-Host }

# Force TLS 1.2 (GitHub requires modern TLS; on PS5.1 this often helps)
Try-Step "Force TLS 1.2" {
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  [Net.ServicePointManager]::SecurityProtocol | Write-Host
}

Write-Section "DNS"
Try-Step "Resolve github.com" {
  Resolve-DnsName github.com -ErrorAction Stop | Select-Object -First 5 Name, Type, IPAddress | Format-Table -AutoSize | Out-String | Write-Host
}

Write-Section "TCP connectivity"
Try-Step "Test-NetConnection github.com:443" {
  $r = Test-NetConnection github.com -Port 443 -InformationLevel Detailed -WarningAction SilentlyContinue
  $r | Select-Object ComputerName, RemoteAddress, RemotePort, TcpTestSucceeded, PingSucceeded, InterfaceAlias | Format-List | Out-String | Write-Host
}

Write-Section "HTTP(S) probes (HEAD)"
$urls = @(
  'https://github.com/',
  'https://github.com/peng1233/offline-file-organizer'
)
foreach ($u in $urls) {
  Try-Step "Invoke-WebRequest HEAD $u" {
    $resp = Invoke-WebRequest -UseBasicParsing -Uri $u -Method Head -TimeoutSec $TimeoutSeconds
    Write-Host ("StatusCode=" + $resp.StatusCode)
    Write-Host ("Server=" + ($resp.Headers['Server'] -join ','))
    Write-Host ("Via=" + ($resp.Headers['Via'] -join ','))
  }
}

Write-Section "Notes"
Write-Host "If TCP succeeds but HEAD fails with reset/empty reply, it may be ISP/proxy/AV/TLS interception."
Write-Host "If both TCP+HEAD fail intermittently, retry later or try a different network route (VPN/proxy) per policy."
