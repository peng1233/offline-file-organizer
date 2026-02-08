param(
  [string]$Name = 'one-pager-short_EN.md',
  # Optional: copy content from an arbitrary raw URL (useful when you want to paste
  # templates without depending on local file encoding).
  [string]$Url = '',
  [switch]$List,
  [switch]$RawUrl,
  [switch]$Print,
  [switch]$NoClipboard
)

$ErrorActionPreference = 'Stop'

try {
  [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding($false)
} catch {}

$root = Split-Path -Parent $PSScriptRoot
$dir = Join-Path $root 'docs\marketplace'

function TryCopy([string]$value, [string]$label){
  if($NoClipboard){
    Write-Host ('(NoClipboard) ' + $label)
    return
  }
  try {
    Set-Clipboard -Value $value
    Write-Host ('Copied to clipboard: ' + $label)
  } catch {
    Write-Host ('Clipboard copy failed: ' + $label)
    if(-not $Print){
      Write-Host 'Tip: re-run with -Print to output the content/url.'
    }
  }
}

if($List){
  $files = Get-ChildItem -LiteralPath $dir -File -Filter '*.md' | Sort-Object Name
  if($RawUrl){
    $files | ForEach-Object {
      'https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/marketplace/' + $_.Name
    }
  } else {
    $files | ForEach-Object { $_.Name }
  }
  exit 0
}

if($Url){
  if($RawUrl){
    Write-Host 'Invalid args: -Url cannot be used with -RawUrl.'
    exit 2
  }
  try {
    $resp = Invoke-WebRequest -UseBasicParsing -Uri $Url
    $textFromUrl = $resp.Content
  } catch {
    Write-Host ('Failed to download URL: ' + $Url)
    throw
  }
  TryCopy -value $textFromUrl -label $Url
  if($Print){ Write-Output $textFromUrl }
  exit 0
}

$path = Join-Path $dir $Name
if(-not (Test-Path -LiteralPath $path -PathType Leaf)){
  Write-Host ('Not found: ' + $path)
  Write-Host 'Tip: run with -List to see available files.'
  exit 2
}

if($RawUrl){
  $url = 'https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/marketplace/' + $Name
  TryCopy -value $url -label $url
  if($Print){ Write-Output $url }
  exit 0
}

$text = Get-Content -LiteralPath $path -Raw -Encoding UTF8
TryCopy -value $text -label $path
if($Print){ Write-Output $text }
