# Platform limits capture checklist (EN)

Goal: help you quickly fill the remaining **[FILL]** fields in `docs/marketplace/assets-index_EN.md` by checking the **actual platform UI**.

Why: platform limits change. The UI you see today is the most reliable source.

Rules:
- Don't paste any secrets.
- Don't paste any personal contact info.
- On Upwork/Fiverr pages: do NOT include off-platform payment/donation links unless the platform explicitly allows it.

---

## What to do (10 minutes)

1) Open `docs/marketplace/assets-index_EN.md`.
2) Search for `[FILL]`.
3) Use the checklists below to locate each limit in the platform editor UI.
4) Replace `[FILL]` with the value you saw (and optionally add a short source note like "UI 2026-02-11").

Tip: if you can't find a limit in the UI, keep it as `[FILL]` and add a note like `not visible in UI; needs verification`.

---

## Fiverr (Gig)

Where: Fiverr -> Selling -> Gigs -> Create a new Gig (or edit an existing draft).

### A) Media uploads (Gallery)

Find in the "Gallery" step:
- Image count limit (how many images you can upload)
- Video allowed? (yes/no)
- Video duration limit
- Video file size limit
- GIF allowed? (some flows allow GIF as an image; verify)

Write back to:
- `Fiverr (Gig) -> Media uploads -> Count limit`
- `Fiverr (Gig) -> Media uploads -> GIF/video`

### B) Requirements/questions

Find in the "Requirements" step:
- Max number of requirement questions/items
- Allowed question types (free text / multiple choice / file upload, etc.)
- Character limits per question (if shown)

Write back to:
- `Fiverr (Gig) -> Requirements/questions: max items`

### C) Link policy (practical)

In the Gig editor UI (usually under "Description"):
- Try to paste a GitHub repo link and see if the UI warns/blocks.
- Try to paste a live demo link (GitHub Pages) and see if it warns/blocks.
- Do NOT test a donation link in a way that would violate policy - keep the safe default unless Fiverr policy explicitly allows.

Write back to:
- `Fiverr (Gig) -> Link policy` fields.

---

## Upwork (Project Catalog / Proposals)

Where: Upwork -> Find Work -> Projects (Project Catalog) editor, and "Submit a proposal" composer.

### A) Proposal attachments

In the proposal composer:
- Check how many attachments can be added (some UI caps this).

Write back to:
- `Upwork -> Attachments -> Max number of attachments`

### B) Project Catalog text limits

In the Project Catalog editor:
- Project title max chars
- Project description max chars

Write back to:
- `Upwork -> Text limits` section.

---

## Toptal / GitHub Sponsors

These are mostly link-based rather than strict asset-upload forms.

- If you see any text limit in the application/profile UI, record it.
- Otherwise keep `[FILL]` and don't guess.

---

## Optional: how to record evidence

If you want stronger "proof" later (for repeatable publishing), capture:
- a screenshot of the UI limit tooltip/message (store locally; do not commit if it contains personal account info)
- or write a one-line note in `assets-index_EN.md` like `Source: UI tooltip (date)`
