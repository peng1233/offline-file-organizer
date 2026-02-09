# Marketplace assets index

This folder contains copy/paste-ready text & checklists for publishing/monetizing this project (Upwork / Fiverr / Toptal / GitHub Sponsors).

## 3-line pitch (copy/paste)

- Offline file organizer you can run in the browser (no upload, privacy-first).
- Batch preview file/folder list, export CSV/TSV, optional ZIP packaging.
- Includes a fully-offline Lite fallback demo: https://peng1233.github.io/offline-file-organizer/lite/

## Start here

- **service-description.md** - main, full description (ZH)
- **service-description-variants.md** - A/B variants (ZH + EN blocks)
- **service-description-short.md** / **service-description-short_EN.md** - shorter versions
- **fiverr-gig-copy_EN.md** - Fiverr gig copy (EN)
- **fiverr-packages-copy_EN.md** - Fiverr package tiers (Basic/Standard/Premium) copy (EN)
- **fiverr-gig.md** - Fiverr gig copy (EN, shorter)
- **fiverr-gig-template.md** - Fiverr gig full-page template (ZH + EN)
- **fiverr-titles-keywords_EN.md** - Fiverr title + keyword ideas (EN)
- **fiverr-faq-copy_EN.md** - Fiverr FAQ copy/paste (EN)
- **upwork-project-catalog-copy_EN.md** - Upwork Project Catalog copy (EN)
- **upwork-proposal-copy_EN.md** - Upwork proposal copy (EN)
- **toptal-profile-copy_EN.md** - Toptal profile copy (EN)
- **github-sponsors-profile-copy_EN.md** - GitHub Sponsors profile + tiers (EN)

## One-pagers

- **one-pager.md** / **one-pager_EN.md** - one-page overview
- **one-pager-short.md** / **one-pager-short_EN.md** - shorter one-pager
- **one-pager-short_ZH.md** - Chinese one-pager (copy/paste)

## Publishing checklists

- **publish-checklist.md** / **publish-checklist_EN.md** - steps before publishing / outreach
- **demo-assets-checklist.md** / **demo-assets-checklist-en.md** - demo assets checklist (screenshots/GIF/etc.)

## Templates

- **platform-profile-template.md** - profile template
- **project-scope-template.md** - scope template (requirements / deliverables)
- **upwork-proposal-template_EN.md** - Upwork proposal template (EN, editable)
- **upwork-project-catalog-template_EN.md** - Upwork Project Catalog template (EN, editable)
- **toptal-application-template_EN.md** - Toptal application/outreach template (EN, editable)
- **platform-keywords-tags.md** - keywords/tags cheat sheet (Upwork/Fiverr/Toptal/Sponsors)
- **pricing-delivery-tiers.md** - pricing tiers + delivery scope template (A/B/C)

## Demo assets (output folder)

- Put screenshots/GIFs referenced by the checklists here: **../assets/**
- See: **../assets/README.md**
- Current ready-to-use GIF (no manual recording): **../assets/lite-demo.gif**
- PNG fallback (if the platform does not support GIF): **../assets/lite-demo.png**
- Raw links (direct download, good for Upwork/Fiverr/Toptal/Sponsors):
  - GIF: https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/assets/lite-demo.gif
  - PNG: https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/assets/lite-demo.png
  - PNG (real screenshot): https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/assets/lite-demo-real.png

## Quick copy/paste to clipboard (Windows)

### Option A (PowerShell)

- List marketplace text templates: `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\copy-marketplace-asset.ps1 -List`
- Copy (default one-pager-short_EN.md): `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\copy-marketplace-asset.ps1`
- Copy specific file: `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\copy-marketplace-asset.ps1 -Name upwork-proposal-copy_EN.md`

### Option B (CMD one-liners)

- List: `cmd /c scripts\copy-marketplace-asset.cmd -List`
- Copy default: `cmd /c scripts\copy-marketplace-asset.cmd`
- Copy specific: `cmd /c scripts\copy-marketplace-asset.cmd -Name upwork-proposal-copy_EN.md`

### Copy from a raw URL (no local file needed)

- Print the text (so you can Ctrl+C manually):
  - `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\copy-marketplace-asset.ps1 -Url https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/marketplace/one-pager-short_EN.md -Print -NoClipboard`

### Get raw links for demo GIF/PNG (docs/assets)

- List available assets: `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\copy-marketplace-asset.ps1 -Kind assets -List`
- Print raw URL for one asset:
  - `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\copy-marketplace-asset.ps1 -Kind assets -Name lite-demo.gif -RawUrl -Print -NoClipboard`

## One-command preflight (before you publish/copy/paste)

Runs minimal checks (no secrets): main + lite self-check, scans marketplace docs for U+FFFD replacement chars, and verifies demo assets exist.

- Run: `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\marketplace-preflight.ps1`

## Quick demo open (for recording GIF/screenshots)

- Run: `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\open-online-demo.ps1`
