# Asset index & platform limits (EN)

Purpose: keep a **single place** to record what each allowed platform accepts (images/GIF/video/attachments/links/text limits), so publishing is repeatable and you don't rediscover the same constraints every time.

This file is intentionally:
- **docs-only** (no secrets)
- **copy/paste friendly**
- **safe defaults** + **fill-in placeholders** (because platform limits change)

---

## Common demo assets (from this repo)

Use these as your default "show, don't tell" assets:

- Lite demo screenshot (PNG): `docs/assets/lite-demo.png`
- Lite demo GIF (if present): `docs/assets/lite-demo.gif`

Live demo entry points:
- Main: https://peng1233.github.io/offline-file-organizer/
- Lite (fully offline-capable): https://peng1233.github.io/offline-file-organizer/lite/

Donation/support:
- BTC tip page: https://peng1233.github.io/btc-receive/
- GitHub Sponsors: https://github.com/sponsors/peng1233

Raw links (useful for platforms that accept URLs but not uploads):
- GitHub raw: https://raw.githubusercontent.com/peng1233/offline-file-organizer/main/docs/assets/

Notes:
- Prefer **PNG** for UI screenshots.
- Prefer **GIF** for short "click-by-click" demos.
- Keep assets small (a safe target is **< 5 MB** per file) to avoid upload failures.

---

## Fiverr (Gig)

Fill these after checking the Fiverr gig creation UI (limits can change).

### Media uploads
- Gig gallery image (source: Fiverr Help Center snippets / Google SERP check):
  - Allowed formats: JPG / PNG
  - Recommended resolution: 1280 x 769 px (72 DPI)
  - Minimum resolution: 712 x 430 px
  - Maximum resolution: 4000 x 2416 px
  - Max file size: 5 MB
  - Count limit: [FILL]
- GIF/video:
  - Allowed: [FILL]
  - Max duration: [FILL]
  - Max file size: [FILL]

### Text limits
- Title max chars: [FILL]
- Description max chars: [FILL]
- FAQ: max items [FILL]; max chars per item [FILL]
- Requirements/questions: max items [FILL]

### Link policy (practical)
- Allowed to include GitHub repo link in description? [FILL]
- Allowed to include live demo link (GitHub Pages)? [FILL]
- Allowed to include donation link (BTC tip page)? [FILL]
  - If unclear, **do not include** donation link on the platform page; keep it only in GitHub README.

---

## Upwork (Project Catalog / Proposals)

### Attachments (Upwork Messages / proposals / projects)
Source (Upwork Help Center): https://support.upwork.com/hc/en-us/articles/360049608113-How-to-share-documents-files-and-more-on-Upwork

- Max size per file: **< 1 GB**
- Supported types (examples from Upwork): `.doc`, `.docx`, `.pdf`, `.txt`, `.ppt`, `.gif`, `.png`
- Unsupported types include many executables (examples from Upwork): `.cmd`, `.exe`, `.bat`, `.jar`, `.lnk`, ...
- Note: `.zip` is not currently supported for iOS devices (per Upwork article)
- Max number of attachments: **[FILL]** (UI-dependent; verify in proposal composer)

### Text limits
- Project title max chars: [FILL]
- Project description max chars: [FILL]
- Proposal cover letter max chars (if relevant): [FILL]

### Link policy (practical + safety)
- Keep communication on Upwork until a contract is in place.
- Do **not** share personal contact info (email/phone/IM) before contract.
- GitHub repo link: usually OK; still verify in your target flow/UI.
- Live demo link (GitHub Pages): usually OK; still verify.
- Donation link (BTC tip page): **avoid on Upwork pages unless explicitly allowed** (keep it on GitHub README instead).

---

## Toptal

Toptal is less "asset upload" oriented and more application/interview driven.

- Application text limits: [FILL]
- Portfolio links allowed: [FILL]
- Best link to share:
  - GitHub repo: https://github.com/peng1233/offline-file-organizer
  - Demo: https://peng1233.github.io/offline-file-organizer/

---

## GitHub Sponsors

- Profile/intro length limits: [FILL]
- Allowed links: (repo/demo/tip page) usually OK, but record any constraints: [FILL]
- Recommended call-to-action text to reuse: see `github-sponsors-profile-copy_EN.md`

---

## "Safe defaults" checklist (when unsure)

If you don't want to research limits right now, these defaults usually work across many platforms:

- Screenshots: PNG, 1280x720 or 1440x900, < 1-2 MB
- GIF: 10-20 seconds, < 5 MB
- Keep text blocks < 1,200 characters (platforms often have tighter limits in some fields)
- Prefer linking to:
  - GitHub repo
  - GitHub Pages demo
- Avoid including:
  - donation links on platform pages (unless clearly allowed)
  - any contact info outside the platform

---

## Changelog

- 2026-02-10: created (template + common asset pointers)
