# Marketplace assets index (images / GIF)

Purpose: quick "what to upload / where to find it" list for Fiverr / Upwork / Toptal / GitHub Sponsors.

All paths below are repo-relative.

## 1) Recommended default assets

- Fiverr cover image (PNG)
  - File: `docs/assets/fiverr-cover.png`
  - How to regenerate (Windows PowerShell):
    - `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/generate-fiverr-cover.ps1`
  - Notes:
    - If Fiverr rejects the size, re-export and try again (platform rules change).

- Main demo GIF (Lite demo mode)
  - File: `docs/assets/lite-demo.gif`
  - Use cases:
    - Fiverr gallery / Upwork project page gallery (if GIF accepted)
    - A "proof it works" animation in listings

- Main demo screenshot (PNG)
  - File: `docs/assets/lite-demo.png`
  - Use cases:
    - When GIF is not accepted / you need a lightweight thumbnail

## 2) Extra screenshots (optional)

- `docs/assets/lite-copy-csv.png` - shows the Copy CSV feature
- `docs/assets/lite-ui.png` - UI overview
- `docs/assets/lite-after-run.png` - "after generating the plan" state
- `docs/assets/lite-demo-real.png` - a more realistic example view
- `docs/assets/lite-home-v10.png` - homepage / landing screenshot
- `docs/assets/tc-donation-v1.png` - donation / tip related (use carefully; some platforms dislike payment links)

## 3) Where this is referenced

- Publish checklists: `docs/marketplace/publish-checklist_EN.md`
- Fiverr steps: `docs/marketplace/fiverr-publish-steps_EN.md`
- Upwork steps: `docs/marketplace/upwork-publish-steps_EN.md`
- Links (copy/paste): `docs/marketplace/links_EN.md`
