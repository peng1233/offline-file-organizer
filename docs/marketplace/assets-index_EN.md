# Marketplace asset index (EN)

Purpose: when you publish on Fiverr / Upwork / Toptal / GitHub Sponsors, you often need the same small set of images/GIFs/links. This page is a quick index so you can find + upload the right files fast.

All paths below are relative to the repo root.

## 1) Recommended default assets

- Cover / title image (PNG)
  - docs/assets/fiverr-cover.png
  - Regenerate (Windows PowerShell 5.1):
    - powershell -NoProfile -ExecutionPolicy Bypass -File scripts/generate-fiverr-cover.ps1
  - Notes:
    - If a platform rejects the size/aspect ratio, re-export with different -Width/-Height.

- Main demo GIF (Lite demo mode)
  - docs/assets/lite-demo.gif
  - Best for gallery preview (if GIF accepted).

- Main demo screenshot (PNG)
  - docs/assets/lite-demo.png
  - Good fallback if GIF is not accepted.

## 2) Extra screenshots (optional)

- docs/assets/lite-demo-real.png (more "real" screenshot)
- docs/assets/lite-ui.png (UI overview)
- docs/assets/lite-home-v10.png (home / landing)
- docs/assets/lite-after-run.png (after running a task)
- docs/assets/lite-copy-csv.png (copy/export style output)

## 3) Monetization / donation assets

- docs/assets/tc-donation-v1.png
  - Donation / tips related. Use carefully (some platforms dislike payment links).

## 4) Where this is referenced

- Publish checklists: docs/marketplace/publish-checklist_EN.md
- Fiverr steps: docs/marketplace/fiverr-publish-steps_EN.md
- Upwork steps: docs/marketplace/upwork-publish-steps_EN.md
- Links (copy/paste): docs/marketplace/links_EN.md
- Cover generation: docs/marketplace/fiverr-cover-asset_EN.md

## Notes

- Keep English copy templates paste-safe (ASCII only). Run:
  - powershell -NoProfile -ExecutionPolicy Bypass -File scripts/marketplace-preflight.ps1
