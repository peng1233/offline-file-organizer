# Fiverr cover image (quick)

Goal: generate a simple, readable cover image for your Fiverr Gig in 1 command.

## Generate (Windows PowerShell 5.1)

From the repo root:

1) Default cover:

- powershell -NoProfile -ExecutionPolicy Bypass -File scripts/generate-fiverr-cover.ps1

2) Customize text:

- powershell -NoProfile -ExecutionPolicy Bypass -File scripts/generate-fiverr-cover.ps1 -Title "Offline File Organizer" -Subtitle "Organize + dedupe your folders (Windows)" -Footer "Demo: https://peng1233.github.io/offline-file-organizer/" -OutPath "docs/assets/fiverr-cover.png"

## Output

- docs/assets/fiverr-cover.png (default)

Tips:
- Keep text short (mobile users).
- Avoid small fonts and too many bullet points.
- Put the demo URL in the footer.
