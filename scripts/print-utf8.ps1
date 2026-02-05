param(
  [Parameter(Mandatory=$true)]
  [string]$Path,

  [int]$Tail = 0
)

$ErrorActionPreference = 'Stop'

if(-not (Test-Path -LiteralPath $Path)){
  throw "File not found: $Path"
}

# Make output as UTF-8 as possible under Windows PowerShell 5.1
try {
  [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding($false)
} catch {}
try {
  $global:OutputEncoding = New-Object System.Text.UTF8Encoding($false)
} catch {}

$bytes = [System.IO.File]::ReadAllBytes((Resolve-Path -LiteralPath $Path))
$text  = [System.Text.Encoding]::UTF8.GetString($bytes)

# Normalize newlines for consistent tail behavior
$lines = $text -split "\r\n|\n|\r"

if($Tail -gt 0){
  $start = [Math]::Max(0, $lines.Length - $Tail)
  $lines = $lines[$start..($lines.Length-1)]
}

$lines -join "`n" | Write-Output
