# Offline File Organizer (Lite)

A **fully-offline** tiny tool that helps you:

1) select multiple files
2) generate new filenames in bulk
3) download the renamed files

By default it downloads files one-by-one. **Optional ZIP download** is supported.

## Privacy
- No upload. Everything runs locally in your browser.
- Works offline: you can double-click `index.html` to run.

## Features
- Rename modes:
  - `prefix-index` (prefix + incremental index)
  - `keepname-prefix` (keep original name + prefix)
  - `replace` (search & replace)
- Filename sanitization for Windows/common filesystems (invalid chars, trailing dots/spaces, etc.)
- Collision detection: warns duplicated names; asks confirmation before download/ZIP
- Export a CSV manifest: `rename-manifest.csv` (helps review / audit)
- **Demo mode**: loads built-in sample files so you can try without preparing files

## ZIP download (optional)
To enable ZIP download, put `vendor/jszip.min.js` next to `index.html`.

## Screenshot

![Lite demo: preview + export CSV](../docs/assets/lite-demo.png)

## Links
- Live demo (Lite): https://peng1233.github.io/offline-file-organizer/lite/
- GitHub repo: https://github.com/peng1233/offline-file-organizer
- Tip page (BTC): https://peng1233.github.io/btc-receive/
