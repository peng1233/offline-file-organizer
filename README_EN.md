# Offline File Organizer (Batch Rename / ZIP)

- Runs **100% locally** (no upload, no network calls)
- Select many files → rename by rules → download as a ZIP

## Quick start
Open `index.html` in your browser.

If you need **folder/directory picking** (File System Access API), some browsers restrict this under `file://`. Use the built-in local server and open via `http://localhost`:

```bash
node tools/serve.js
```

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

## Support (BTC)
Donation page: https://peng1233.github.io/btc-receive/
