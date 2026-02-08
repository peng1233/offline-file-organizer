# Publishing / outreach checklist (Upwork / Fiverr / Toptal / GitHub Sponsors)

Purpose: turn the repo's ready-to-copy text + demo assets into a clean service page / proposal, with minimal friction and no surprises.

Rules:
- Never paste or store any secrets (tokens, private keys, payout details).
- The final submit/publish step is manual (human confirmation).

## Fast copy (Windows PowerShell)

Run inside the repo folder:

- Copy this checklist (file content):
  - powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\copy-marketplace-asset.ps1 -Name publish-checklist_EN.md
- Print to terminal (manual Ctrl+C, safer on some platforms):
  - powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\copy-marketplace-asset.ps1 -Name publish-checklist_EN.md -Print -NoClipboard

## 0) Pick ONE primary selling angle

Pick one and stay consistent across the whole page/proposal:

- Privacy-first / offline: runs locally in the browser, no upload.
- Efficiency: batch preview, export CSV/TSV manifest, optional ZIP packaging.
- Windows-friendly: simple local usage, predictable output, easy rollback.

## 1) Links you will paste everywhere

Source: docs/marketplace/links.md

Make sure you have:
- GitHub repo link
- GitHub Pages demo (main) + Lite demo link
- Direct raw links for 1 GIF + 1 PNG (for platforms that block GIF)

## 2) Copy/paste-ready service text

Start from:
- docs/marketplace/service-description.md (ZH)
- docs/marketplace/service-description-variants.md (ZH + EN blocks)
- docs/marketplace/service-description-short_EN.md (EN, short)

Also useful templates:
- docs/marketplace/platform-profile-template.md
- docs/marketplace/project-scope-template.md
- docs/marketplace/pricing-delivery-tiers.md

## 3) Demo assets (screenshots / GIF)

Checklist:
- docs/marketplace/demo-assets-checklist.md

Minimum recommended:
- 1 GIF (Lite demo) + 1 PNG fallback

Tip (Lite demo flow):
1) Open the Lite page
2) Click Load demo
3) Preview items
4) Click Copy CSV (show the manifest export)

## 4) Upwork proposal structure

Suggested structure (keep it tight):
1) 1-sentence summary of the outcome
2) 3 bullets: what you will do
3) Scope + deliverables (from project-scope-template.md)
4) Timeline + price (can be ranges)
5) Safety / rollback promise (no destructive changes)
6) Demo link + 1 GIF/PNG

## 5) Fiverr gig structure

- Title: emphasize Offline / Batch / CSV manifest
- Description: reuse an EN block from service-description-variants.md
- FAQ: reuse common Q&A from project-scope-template.md
- Gallery: 1 screenshot + Lite demo GIF/PNG

## 6) Toptal application / outreach notes

- Emphasize: offline, privacy-first, no cloud upload
- Use: README_EN.md + docs/windows-quickstart-en.md
- Prepare 1-2 paragraphs: why offline matters for clients

## 7) GitHub Sponsors page

- Keep the profile in plain ASCII (reduces formatting issues when copy/pasting)
- Show: value, demo link, what sponsorship unlocks, simple tiers

---

## 30-second preflight (before you copy/paste)

- [ ] Marketplace preflight passes: powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\marketplace-preflight.ps1
- [ ] Links open correctly (Pages works)
- [ ] No secrets included
- [ ] Promises are realistic and deliverables are reversible
