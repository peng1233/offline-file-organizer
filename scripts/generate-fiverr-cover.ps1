param(
  [string]$Title = "Offline File Organizer",
  [string]$Subtitle = "Organize + dedupe your folders (Windows)",
  [string]$Footer = "Demo: https://peng1233.github.io/offline-file-organizer/",
  [string]$OutPath = "docs/assets/fiverr-cover.png",
  [int]$Width = 1280,
  [int]$Height = 769
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Resolve-OutPath([string]$Path) {
  if ([System.IO.Path]::IsPathRooted($Path)) { return $Path }
  return (Join-Path (Get-Location) $Path)
}

$absOutPath = Resolve-OutPath $OutPath
$absOutDir = Split-Path -Parent $absOutPath
if (-not (Test-Path $absOutDir)) {
  New-Item -ItemType Directory -Path $absOutDir | Out-Null
}

Add-Type -AssemblyName System.Drawing

$bmp = New-Object System.Drawing.Bitmap($Width, $Height)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

try {
  # Background
  $bg = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Rectangle(0, 0, $Width, $Height)),
    [System.Drawing.Color]::FromArgb(255, 16, 24, 40),
    [System.Drawing.Color]::FromArgb(255, 52, 84, 180),
    [System.Drawing.Drawing2D.LinearGradientMode]::ForwardDiagonal
  )
  $g.FillRectangle($bg, 0, 0, $Width, $Height)

  # Accent bar
  $accentBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(220, 255, 190, 0))
  $g.FillRectangle($accentBrush, 0, 0, $Width, [math]::Max(10, [math]::Floor($Height * 0.06)))

  # Text
  $white = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
  $muted = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(230, 230, 240, 255))
  $shadow = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(120, 0, 0, 0))

  $titleFont = New-Object System.Drawing.Font("Arial", [math]::Max(36, [math]::Floor($Height * 0.08)), [System.Drawing.FontStyle]::Bold)
  $subFont = New-Object System.Drawing.Font("Arial", [math]::Max(20, [math]::Floor($Height * 0.04)), [System.Drawing.FontStyle]::Regular)
  $footFont = New-Object System.Drawing.Font("Consolas", [math]::Max(14, [math]::Floor($Height * 0.025)), [System.Drawing.FontStyle]::Regular)

  $padX = [math]::Floor($Width * 0.06)
  $padY = [math]::Floor($Height * 0.18)

  $rectW = [single]($Width - ($padX * 2))
  $titleRect = New-Object System.Drawing.RectangleF([single]$padX, [single]$padY, $rectW, [single]$Height)
  $subRect = New-Object System.Drawing.RectangleF([single]$padX, [single]($padY + [math]::Floor($Height * 0.15)), $rectW, [single]$Height)
  $footRect = New-Object System.Drawing.RectangleF([single]$padX, [single]($Height - [math]::Floor($Height * 0.10)), $rectW, [single]$Height)

  $format = New-Object System.Drawing.StringFormat
  $format.Alignment = [System.Drawing.StringAlignment]::Near
  $format.LineAlignment = [System.Drawing.StringAlignment]::Near

  # Shadow (slight offset)
  $shadowOffset = [single]([math]::Max(2, [math]::Floor($Height * 0.004)))
  $g.DrawString($Title, $titleFont, $shadow, (New-Object System.Drawing.RectangleF([single]($titleRect.X + $shadowOffset), [single]($titleRect.Y + $shadowOffset), [single]$titleRect.Width, [single]$titleRect.Height)), $format)
  $g.DrawString($Subtitle, $subFont, $shadow, (New-Object System.Drawing.RectangleF([single]($subRect.X + $shadowOffset), [single]($subRect.Y + $shadowOffset), [single]$subRect.Width, [single]$subRect.Height)), $format)

  $g.DrawString($Title, $titleFont, $white, $titleRect, $format)
  $g.DrawString($Subtitle, $subFont, $muted, $subRect, $format)

  if ($Footer -and $Footer.Trim().Length -gt 0) {
    $g.DrawString($Footer, $footFont, $muted, $footRect, $format)
  }

  $bmp.Save($absOutPath, [System.Drawing.Imaging.ImageFormat]::Png)
}
finally {
  $g.Dispose()
  $bmp.Dispose()
}

Write-Host "COVER_OK => $absOutPath"
