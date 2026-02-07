param(
  [switch]$LiteOnly,
  [switch]$MainOnly
)

$ErrorActionPreference = 'Stop'

$main = 'https://peng1233.github.io/offline-file-organizer/'
$lite = 'https://peng1233.github.io/offline-file-organizer/lite/'

if ($MainOnly -and $LiteOnly) {
  Write-Host 'FAIL: do not use -MainOnly and -LiteOnly together.'
  exit 1
}

if (-not $LiteOnly) {
  Write-Host ('Opening main demo: ' + $main) -ForegroundColor Cyan
  Start-Process $main
}

if (-not $MainOnly) {
  Write-Host ('Opening lite demo: ' + $lite) -ForegroundColor Cyan
  Start-Process $lite
}

Write-Host 'OK' -ForegroundColor Green
