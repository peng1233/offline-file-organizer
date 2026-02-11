# Offline File Organizer (Batch Rename / ZIP)

- Runs **100% locally** (no upload, no network calls)
- Select many files -> rename by rules -> download as a ZIP

## Quick start
Open `index.html` in your browser.

Tip: Before downloading the ZIP, you can export a CSV manifest (old_name/new_name/size_bytes) for preview, QA, and easy rollback. You can also click **Copy CSV**. If clipboard permission is blocked (common under file://), the page will show a textarea fallback so you can Ctrl+C manually.

Windows:
- Double-click `open.cmd` for the **quick file://** open (fastest, but some browsers restrict folder picking under `file://`).
- Use `tools/serve.ps1` (recommended) / `node tools/serve.js` for the **localhost http://** mode (best compatibility with folder/directory picking).

`open.cmd` also supports command line options (help):

```bat
open.cmd -help
```

Common examples:
- Open Lite: `open.cmd -Lite`
- Open via localhost (more permissions/features): `open.cmd -Server`
- Custom port: `open.cmd -Server -Port 5174`
- Start server without auto-opening browser: `open.cmd -Server -NoOpen`

If you already have Node.js installed, you can also start via PowerShell (recommended on Windows):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\open.ps1 -Server
# Lite:
# powershell -NoProfile -ExecutionPolicy Bypass -File .\open.ps1 -Server -Lite
```

If you need **folder/directory picking** (File System Access API), some browsers restrict this under `file://`. Use the built-in local server and open via `http://localhost`:

```bash
node tools/serve.js
```

Windows one-command start (PowerShell script): `docs/windows-quickstart.md`

Then open:
- Main: `http://127.0.0.1:5173/`
- Lite: `http://127.0.0.1:5173/lite/`

## Fully-offline fallback (Lite)
If your environment cannot load third-party libraries or ZIP generation fails, use the Lite version:
- Entry: `lite/index.html`
- Features: zero dependencies; batch rename; download one-by-one; export CSV manifest; **Copy CSV** (clipboard with fallback); ZIP is an optional enhancement.

Demo screenshot (Lite supports **Load demo (no files)** for quick understanding):

![Lite demo](docs/assets/lite-demo.png)

Demo assets (raw links you can paste into Upwork/Fiverr/Toptal/GitHub Sponsors):
- GIF: https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/assets/lite-demo.gif
- PNG (fallback): https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/assets/lite-demo.png
- PNG (real screenshot): https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/assets/lite-demo-real.png

## Tips (rename rules)
- Replace mode: the "from" field cannot be empty.
- For older browsers without `String.prototype.replaceAll`, the tool automatically falls back to a compatible implementation.

## Freelance / delivery template
If you deliver this tool as a small freelance task (Upwork/Fiverr/Toptal) or want a clear acceptance checklist, use this one-page template:
- `docs/marketplace/project-scope-template.md`

## Marketplace copy/paste templates (Upwork/Fiverr/Toptal)
- Index: `docs/marketplace/README.md`
- Platform keywords/tags cheat sheet: `docs/marketplace/platform-keywords-tags.md`
- Pricing tiers / deliverables template (A/B/C): `docs/marketplace/pricing-delivery-tiers.md`
- Publishing checklist (EN): `docs/monetization/publish-checklist_EN.md`
- Fiverr Gig template: `docs/monetization/fiverr-gig-template.md`
- Fiverr Gig copy (EN): `docs/marketplace/fiverr-gig-copy_EN.md`
- Service packages (Fiverr + Upwork pricing + deliverables): `docs/monetization/service-packages_Fiverr_Upwork.md`
- GitHub Sponsors setup checklist: `docs/monetization/github-sponsors-checklist.md`
- Upwork proposal (long): `docs/monetization/upwork-proposal-template.md`
- Upwork proposal (short EN, 300-600 words): `docs/monetization/upwork-proposal-template-short_EN.md`
- Upwork proposal (mini EN, 150-250 words): `docs/monetization/upwork-proposal-template-mini_EN.md`
- Service description (short, CN/EN): `docs/marketplace/service-description-short.md` / `docs/marketplace/service-description-short_EN.md`
- One-pager (short, CN/EN): `docs/marketplace/one-pager-short.md` / `docs/marketplace/one-pager-short_EN.md`
- One-pager (long, CN/EN): `docs/marketplace/one-pager.md` / `docs/marketplace/one-pager_EN.md`
- Demo assets checklist (screenshots/GIFs to prepare): `docs/marketplace/demo-assets-checklist.md`

## GitHub Sponsors
If this tool saves you time (or helps you deliver freelance work faster), you can support ongoing maintenance here:
- https://github.com/sponsors/peng1233

## Donation (BTC)
If this tool saved you time, you can support it here:
- https://peng1233.github.io/btc-receive/

