param(
  # Copy/paste helper for publishing/monetizing assets.
  # Backward-compatible default: marketplace markdown one-pagers.
  [ValidateSet('marketplace','assets')]
  [string]$Kind = 'marketplace',

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

# If user did not specify -Name explicitly and they want assets, pick a sensible default.
if ($Kind -eq 'assets' -and (-not $PSBoundParameters.ContainsKey('Name'))) {
  $Name = 'lite-demo.gif'
}

if ($Kind -eq 'assets') {
  $dir = Join-Path $root 'docs\assets'
} else {
  $dir = Join-Path $root 'docs\marketplace'
}

function TryCopy([string]$value, [string]$label) {
  if ($NoClipboard) {
    Write-Host ('(NoClipboard) ' + $label)
    return
  }
  try {
    Set-Clipboard -Value $value
    Write-Host ('Copied to clipboard: ' + $label)
  } catch {
    Write-Host ('Clipboard copy failed: ' + $label)
    if (-not $Print) {
      Write-Host 'Tip: re-run with -Print to output the content/url.'
    }
  }
}

if ($List) {
  if (-not (Test-Path -LiteralPath $dir)) {
    Write-Host ('Not found: ' + $dir)
    exit 2
  }

  $files = @()
  if ($Kind -eq 'assets') {
    $files = Get-ChildItem -LiteralPath $dir -File | Sort-Object Name
  } else {
    $files = Get-ChildItem -LiteralPath $dir -File -Filter '*.md' | Sort-Object Name
  }

  if ($RawUrl) {
    if ($Kind -eq 'assets') {
      $files | ForEach-Object {
        'https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/assets/' + $_.Name
      }
    } else {
      $files | ForEach-Object {
        'https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/marketplace/' + $_.Name
      }
    }
  } else {
    $files | ForEach-Object { $_.Name }
  }
  exit 0
}

if ($Url) {
  if ($RawUrl) {
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
  if ($Print) { Write-Output $textFromUrl }
  exit 0
}

$path = Join-Path $dir $Name
if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
  Write-Host ('Not found: ' + $path)
  Write-Host 'Tip: run with -List to see available files.'
  exit 2
}

if ($RawUrl) {
  if ($Kind -eq 'assets') {
    $urlOut = 'https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/assets/' + $Name
  } else {
    $urlOut = 'https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/marketplace/' + $Name
  }
  TryCopy -value $urlOut -label $urlOut
  if ($Print) { Write-Output $urlOut }
  exit 0
}

if ($Kind -eq 'assets') {
  Write-Host 'Invalid args: assets cannot be copied as text. Use -RawUrl for a stable link.'
  exit 2
}

$text = Get-Content -LiteralPath $path -Raw -Encoding UTF8
TryCopy -value $text -label $path
if ($Print) { Write-Output $text }
