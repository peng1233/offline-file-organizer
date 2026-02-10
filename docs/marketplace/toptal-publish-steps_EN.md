# Toptal publish steps (draft-first)

This is a practical checklist for applying on Toptal using this project as a portfolio + service offering.

Goal: create a clean, honest, repeatable application package you can reuse.

## 0) Preflight (do this first)

From the repo root:

- Run: `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\marketplace-preflight.ps1`
- If it prints `PRECHECK_OK`, you are safe to copy/paste templates and share demo links.

## 1) Prepare your portfolio package

Use these assets (all in `docs/marketplace/`):

- One-pager:
  - `one-pager-short_EN.md`
- Project description (service copy):
  - `service-description.md`
- Toptal-specific application template:
  - `toptal-application-template_EN.md`

Useful links (copy as-is):

- Repo: https://github.com/peng1233/offline-file-organizer
- Live Lite demo: https://peng1233.github.io/offline-file-organizer/lite/
- BTC tip page (optional): https://peng1233.github.io/btc-receive/

## 2) Create a draft application (do NOT submit yet)

In the Toptal application flow, fill in a draft with:

- Clear title:
  - "Offline File Organizer (privacy-first, runs in browser, works without internet)"
- Short summary:
  - What problem it solves
  - Who it helps
  - What makes it different (offline / privacy / quick batch organize)
- Proof:
  - Link to GitHub repo
  - Link to live demo
  - 1-2 screenshots or a short GIF (see `assets-index_EN.md`)

## 3) Quality gate (before final submit)

Check these items:

- No secrets: do not paste tokens, emails, private keys.
- No overclaims: do not claim features you cannot demo.
- Copy/paste safety: avoid smart quotes and non-ASCII symbols in platform text.
- Delivery story:
  - What you will deliver to clients (ZIP + instructions)
  - Basic support window (for example: 7 days)

## 4) Final submit (manual)

Only submit when:

- The draft reads clearly in plain English.
- Demo links open reliably.
- You can answer "how does it run offline" in one sentence.

## Notes

- Do not bypass Toptal rules.
- Keep everything honest and verifiable.
