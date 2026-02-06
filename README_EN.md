# Offline File Organizer (Batch Rename / ZIP)

- Runs **100% locally** (no upload, no network calls)
- Select many files → rename by rules → download as a ZIP

## Quick start
Open `index.html` in your browser.

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

Demo screenshot (Lite supports **“Load demo (no files)”** for quick understanding):

![Lite demo](docs/assets/lite-demo.png)

## Tips (rename rules)
- Replace mode: the "from" field cannot be empty.
- For older browsers without `String.prototype.replaceAll`, the tool automatically falls back to a compatible implementation.

## Freelance / delivery template
If you deliver this tool as a small freelance task (Upwork/Fiverr/Toptal) or want a clear acceptance checklist, use this one-page template:
- `docs/marketplace/project-scope-template.md`

## Marketplace copy/paste templates (Upwork/Fiverr/Toptal)
- Fiverr Gig template: `docs/monetization/fiverr-gig-template.md`
- Upwork proposal (long): `docs/monetization/upwork-proposal-template.md`
- Upwork proposal (short EN, 300-600 words): `docs/monetization/upwork-proposal-template-short_EN.md`
- Upwork proposal (mini EN, 150-250 words): `docs/monetization/upwork-proposal-template-mini_EN.md`
- Service description (short, CN/EN): `docs/marketplace/service-description-short.md` / `docs/marketplace/service-description-short_EN.md`
- One-pager (short, CN/EN): `docs/marketplace/one-pager-short.md` / `docs/marketplace/one-pager-short_EN.md`

## GitHub Sponsors
If this tool saves you time (or helps you deliver freelance work faster), you can support ongoing maintenance here:
- https://github.com/sponsors/peng1233

## Support (BTC)
Donation page: https://peng1233.github.io/btc-receive/
