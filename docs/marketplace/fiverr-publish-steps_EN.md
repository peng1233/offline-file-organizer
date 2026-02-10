# Fiverr publish steps (copy/paste safe)

Goal: publish 1 Fiverr Gig for Offline File Organizer (Lite).
This is a step-by-step checklist that references the prepared copy assets in this folder.

## Before you start
- Run preflight (should say PRECHECK_OK):
  - powershell -NoProfile -ExecutionPolicy Bypass -File scripts/marketplace-preflight.ps1
- Have demo assets ready (already in repo):
  - docs/assets/lite-demo.gif
  - docs/assets/lite-demo.png
  - docs/assets/lite-demo-real.png

## 1) Create the Gig
In Fiverr: "My Business" -> "Gigs" -> "Create a new Gig".

## 2) Overview
- Title: pick one from docs/marketplace/fiverr-titles-keywords_EN.md
- Category/Subcategory: "Programming & Tech" (or closest) -> "Software Development" (adjust as Fiverr UI changes)
- Search tags: pick 5 from docs/marketplace/fiverr-titles-keywords_EN.md

## 3) Scope & Pricing (Packages)
- Use docs/marketplace/fiverr-packages-copy_EN.md as the source of Basic/Standard/Premium text.
- Keep delivery times realistic; avoid overpromising.
- Add "Revisions" and "Number of files" only if Fiverr forces it; keep them minimal/clear.

## 4) Description
- Paste from docs/marketplace/fiverr-gig-copy_EN.md
- Optional: include quick links (plain text, no fancy characters):
  - GitHub: https://github.com/peng1233/offline-file-organizer
  - Tips (BTC): https://peng1233.github.io/btc-receive/

## 5) FAQ
- Paste from docs/marketplace/fiverr-faq-copy_EN.md

## 6) Requirements (questions to buyer)
Ask for only what is needed to deliver:
- OS (Windows version)
- Folder size / approximate file count
- What output they want (organized folders / renamed files / CSV report)
- Any naming rules to follow

## 7) Gallery
Upload:
- docs/assets/lite-demo.gif
- docs/assets/lite-demo.png
- docs/assets/lite-demo-real.png
Use captions from docs/marketplace/fiverr-gallery-captions_EN.md (if needed).

## 8) Publish
- Final review for typos and pricing.
- Publish.

## Post-publish quick checks
- Search your own Gig title on Fiverr (private browser) to confirm it is visible.
- Verify the first line of the description is compelling.
- Verify gallery order: GIF first.
