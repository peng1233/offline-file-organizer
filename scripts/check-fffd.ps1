param(
  [string]$Path = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
  [string[]]$Include = @('*.md','*.html','*.ps1','*.js','*.txt'),
  [string[]]$ExcludeDir = @('.git','node_modules','dist'),
  [switch]$Quiet
)

# Scan repo for Unicode replacement character U+FFFD (often indicates mojibake/encoding damage)
# PowerShell 5.1 note: Get-ChildItem -Filter only supports one pattern, so we loop.

[Console]::OutputEncoding = New-Object System.Text.UTF8Encoding($false)

function Get-Files {
  foreach ($pat in $Include) {
    Get-ChildItem -Path $Path -Recurse -File -Filter $pat -ErrorAction SilentlyContinue |
      Where-Object {
        $full = $_.FullName
        foreach ($d in $ExcludeDir) {
          if ($full -like "*\\$d\\*") { return $false }
        }
        return $true
      }
  }
}

$files = Get-Files | Sort-Object FullName -Unique
$hit = @()

foreach ($f in $files) {
  try {
    $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $text = [System.Text.Encoding]::UTF8.GetString($bytes)
    if ($text.IndexOf([char]0xFFFD) -ge 0) {
      $hit += $f.FullName
      if (-not $Quiet) {
        Write-Host "HIT: $($f.FullName)" -ForegroundColor Yellow
      }
    }
  } catch {
    if (-not $Quiet) {
      Write-Host "WARN: failed to read $($f.FullName): $($_.Exception.Message)" -ForegroundColor DarkYellow
    }
  }
}

if ($hit.Count -eq 0) {
  Write-Host "OK: no U+FFFD replacement character found in $($files.Count) file(s)." -ForegroundColor Green
  exit 0
}

Write-Host "FAIL: found U+FFFD replacement character in $($hit.Count) file(s)." -ForegroundColor Red
exit 2
