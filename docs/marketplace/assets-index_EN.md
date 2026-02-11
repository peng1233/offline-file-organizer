# Asset index & platform limits (EN)

Purpose: keep a **single place** to record what each allowed platform accepts (images/GIF/video/attachments/links/text limits), so publishing is repeatable and you don't rediscover the same constraints every time.

Quick helper: if you're filling `TBD_UI` fields from the platform UI, use: `docs/marketplace/platform-limits-capture-checklist_EN.md`

This file is intentionally:
- **docs-only** (no secrets)
- **copy/paste friendly**
- **safe defaults** + **fill-in placeholders** (because platform limits change)

---

## Common demo assets (from this repo)

Use these as your default "show, don't tell" assets.

### Recommended (top 3)

1) **Cover image (Fiverr / listings):** `docs/assets/fiverr-cover.png`
   - Suggested title/caption: "Offline File Organizer (Privacy-first)" / "Rename files in bulk - works offline"

2) **Real UI screenshot (most convincing):** `docs/assets/lite-demo-real.png`
   - Suggested title/caption: "Demo - preview renamed files" / "Export or copy CSV rename plan"

3) **Lite demo screenshot (simple + clean):** `docs/assets/lite-demo.png`
   - Suggested title/caption: "Fully offline-capable (Lite mode)" / "No uploads, files stay on your device"

### Optional

- Lite demo GIF (if present): `docs/assets/lite-demo.gif`
  - Suggested title/caption: "30-second walkthrough" / "Pick folder -> preview -> export/copy CSV"

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
- Gig gallery image (source: Fiverr Help Center "Creating a Gig" > Step 5: Gallery > Images: https://help.fiverr.com/hc/en-us/articles/360010451397-Creating-a-Gig ):
  - Allowed formats: JPG / PNG
  - Recommended resolution: 1280 x 769 px (72 DPI)
  - Minimum resolution: 712 x 430 px
  - Maximum resolution: 4000 x 2416 px
  - Max file size: 5 MB
  - Count limit: **at least 1 image** and **up to 3 images** (source above)
- GIF/video:
  - Allowed: TBD_UI (verify in Fiverr Gig editor UI)
  - Max duration: TBD_UI (verify in Fiverr Gig editor UI)
  - Max file size: TBD_UI (verify in Fiverr Gig editor UI)

### Text limits
- Title max chars: **80** (community references; e.g. https://homeearningtip.tistory.com/110)
- Description max chars: **1,200** (Fiverr Help Center search snippet: "Description field... up to 1,200 characters"; see search results: https://help.fiverr.com/hc/en-us/search?query=Creating%20a%20Gig%201%2C200%20characters )
- FAQ: max items **10**; max chars per answer **300** (source: Fiverr Blog "How to Optimize Your Gigs to Maximize Your Sales": https://blog.fiverr.com/post/how-to-optimize-your-gigs-to-maximize-your-sales )
- Requirements/questions: max items TBD_UI (not found in an official public source yet; verify in Fiverr Gig editor UI)
  - Ready-to-paste text: `docs/marketplace/fiverr-requirements-questions_EN.md`
- Ready-to-paste gig copy (title/tags/description/FAQ): `docs/marketplace/fiverr-gig-copy_EN.md`

### Link policy (practical + safety)
- Allowed to include GitHub repo link in description? TBD_UI (verify in Fiverr policy/UI)
- Allowed to include live demo link (GitHub Pages)? TBD_UI (verify in Fiverr policy/UI)
- Allowed to include donation link (BTC tip page)? TBD_UI (verify in Fiverr policy/UI; default is avoid)
  - Safe default: **do not include** donation/tip links on Fiverr pages unless the policy is clearly OK; keep it only in GitHub README.

---

## Upwork (Project Catalog / Proposals)

### Project Catalog media (images / video)
Source (Upwork Help Center): https://support.upwork.com/hc/en-us/articles/1500011309082-How-to-add-images-and-video-to-your-Project-Catalog-project

Images:
- Formats: JPEG / PNG
- Max file size: < 10 MB per image
- Aspect ratio: 4:3
- Max dimension: no larger than 4000 px (width or height)
- Display size hint: should look sharp at 1000 x 750 px (that's how it appears in Project Catalog)
- Max count: up to 20 images per project

Video:
- Max count: 1 video per project
- Format: mp4 only
- Max duration: up to 60 seconds
- Max file size: up to 100 MB

### Attachments (Upwork Messages / proposals / projects)
Source (Upwork Help Center): https://support.upwork.com/hc/en-us/articles/360049608113-How-to-share-documents-files-and-more-on-Upwork

- Max size per file: **< 1 GB**
- Supported types (examples from Upwork): `.doc`, `.docx`, `.pdf`, `.txt`, `.ppt`, `.gif`, `.png`
- Unsupported types include many executables (examples from Upwork): `.cmd`, `.exe`, `.bat`, `.jar`, `.lnk`, ...
- Note: `.zip` is not currently supported for iOS devices (per Upwork article)
- Max number of attachments: **TBD_UI** (UI-dependent; verify in proposal composer)

### Text limits
- Project title max chars: TBD_UI (UI-dependent; verify in Project Catalog editor)
- Project description max chars: TBD_UI (UI-dependent; verify in Project Catalog editor)
- Proposal cover letter max chars (if relevant): TBD_UI (UI-dependent; verify in proposal composer)

### Other known Project Catalog constraints
Source (Upwork Help Center): https://support.upwork.com/hc/en-us/articles/360057397533-How-to-create-a-project-in-Project-Catalog

- Search tags: add up to **5** tags
- Package tiers: up to **3** tiers (Starter / Standard / Advanced)
- Pricing range: **$5 USD** to **$500,000 USD**

### Project count limits
Source (Upwork Help Center): https://support.upwork.com/hc/en-us/articles/360057397533-How-to-create-a-project-in-Project-Catalog

- You can post **up to 20 unique projects** in Project Catalog at any one time.
- You can also have **up to 20 more projects in review**.

### Link policy (practical + safety)
- Keep communication on Upwork until a contract is in place.
- Do **not** share personal contact info (email/phone/IM) before contract.
- GitHub repo link: usually OK; still verify in your target flow/UI.
- Live demo link (GitHub Pages): usually OK; still verify.
- Donation link (BTC tip page): **avoid on Upwork pages unless explicitly allowed** (keep it on GitHub README instead).

---

## Toptal

Toptal is less "asset upload" oriented and more application/interview driven.

- Application text limits: TBD_UI (verify in Toptal application UI)
- Portfolio links allowed: TBD_UI (verify in Toptal application UI)
- Best link to share:
  - GitHub repo: https://github.com/peng1233/offline-file-organizer
  - Demo: https://peng1233.github.io/offline-file-organizer/

---

## GitHub Sponsors

- Profile/intro length limits: TBD_UI (verify in GitHub Sponsors profile editor UI)
- Allowed links: (repo/demo/tip page) usually OK, but record any constraints: TBD_UI (verify in GitHub Sponsors profile editor UI)
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

- 2026-02-11: filled Fiverr title/description limits (80 / 1,200) with Help Center search snippet references
- 2026-02-10: created (template + common asset pointers)
