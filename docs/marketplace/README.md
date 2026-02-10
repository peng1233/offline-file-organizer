# Marketplace assets (Upwork / Fiverr / Toptal / GitHub Sponsors)

This folder contains copy/paste-ready text assets for publishing and monetizing this project on the **allowed platforms**:

- Upwork
- Fiverr
- Toptal
- GitHub Sponsors

It is intentionally **docs-only** (no secrets, no tokens).

## Quick start

If you want the fastest path to publish:

1) Read: `publish-checklist_EN.md`
2) Use the "one page" summary:
   - English: `one-pager-short_EN.md`
   - Chinese: `one-pager-short_ZH.md`
3) Pick one platform template:
   - Fiverr gig: `fiverr-gig-template.md` (or ready copy: `fiverr-gig-copy_EN.md`)
   - Fiverr packages (Basic/Standard/Premium): `fiverr-packages.md`
   - Upwork proposal: `upwork-proposal-template_EN.md` (or ready copy: `upwork-proposal-copy_EN.md`)
   - Toptal application: `toptal-application-template_EN.md`
   - GitHub Sponsors profile: `github-sponsors-profile-copy_EN.md`
4) Follow a platform-specific publish steps checklist (create a draft first):
   - Fiverr: `fiverr-publish-steps_EN.md`
   - Upwork Project Catalog: `upwork-publish-steps_EN.md`

## Demo assets

Recommended demo entry points:

- GitHub repo: https://github.com/peng1233/offline-file-organizer
- Live Lite demo (fully offline-capable): https://peng1233.github.io/offline-file-organizer/lite/
- BTC tip page: https://peng1233.github.io/btc-receive/

How to create GIF/screenshots on Windows:
- `how-to-record-gif-windows.md`

Asset index (what to upload where):
- `assets-index_EN.md`

## Naming notes

- Files ending with `_EN` are English-first.
- Files without suffix may be bilingual or Chinese.

## Safety

- Do not store any API keys/tokens here.
- Avoid including personal identity data that platforms dont require.

## Quick copy/paste to clipboard (Windows)

### Option A (PowerShell)

- List marketplace text templates: `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\copy-marketplace-asset.ps1 -List`
- Copy (default one-pager-short_EN.md): `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\copy-marketplace-asset.ps1`
- Copy specific file: `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\copy-marketplace-asset.ps1 -Name upwork-proposal-copy_EN.md`

### Option B (CMD one-liners)

- List: `cmd /c scripts\copy-marketplace-asset.cmd -List`
- Copy default: `cmd /c scripts\copy-marketplace-asset.cmd`
- Copy specific: `cmd /c scripts\copy-marketplace-asset.cmd -Name upwork-proposal-copy_EN.md`

### Option C (copy any local file)

If you just want to copy a local file to clipboard (no naming rules):

- `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\copy-to-clipboard.ps1 -Path .\docs\marketplace\fiverr-gig-copy_EN.md`

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

## Pack everything into a ZIP (for uploading to platforms)

Creates a single ZIP containing:
- `docs/marketplace/` text templates (copy/paste)
- a few commonly-used demo assets from `docs/assets/` (GIF/PNG)
- (optional) donation QR image **only if you explicitly pass** `-IncludeDonationQr`

- PowerShell: `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\marketplace-pack.ps1`
- Include donation QR (only when allowed by the platform): `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\marketplace-pack.ps1 -IncludeDonationQr`
- CMD wrapper: `cmd /c .\scripts\marketplace-pack.cmd`

The ZIP is saved to `dist/marketplace-pack_YYYYMMDD_HHMMSS.zip` by default.

After the script finishes, it prints:
- `OutPath: ...` (the exact ZIP path)
- `SHA256: ...` (file hash) - you can paste this into your platform message / delivery notes so the client can verify integrity

## Quick demo open (for recording GIF/screenshots)

- Run: `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\open-online-demo.ps1`

## Build offline ZIP (for delivery)

- Main (full demo):
  - Run: `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\build-main-release.ps1`
  - Output: `dist/offline-file-organizer-main.zip` + `dist/RELEASE_MAIN.txt`

- Lite (small fallback):
  - Run: `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\build-lite-release.ps1`
  - Output: `lite/dist/offline-file-organizer-lite.zip` + `lite/dist/RELEASE.txt`

## Support / Tips

- BTC tips: https://peng1233.github.io/btc-receive/
- GitHub Sponsors: https://github.com/sponsors/peng1233
