# Offline File Organizer - Short Service Description (Upwork / Fiverr)

A short, platform-friendly description you can paste into a listing. No pricing, no over-promises.

## What I deliver
A **fully offline** browser-based file organizer:
- Batch rename files (template / sequence / date)
- Export a CSV manifest (for tracking, delivery, archiving)
- Optional ZIP download; if ZIP isn't available, it still works via a **Lite offline fallback** (download one-by-one)

## Highlights
- Zero install (open the HTML)
- No uploads / privacy-friendly
- Customizable rules
- Small, rollback-friendly changes

## Demo
- Main: https://peng1233.github.io/offline-file-organizer/
- Lite: https://peng1233.github.io/offline-file-organizer/lite/

## Repo
https://github.com/peng1233/offline-file-organizer

## Quick FAQ
- Why "localhost" sometimes? Some browsers restrict folder access on `file://`. Running a tiny local server enables the File System Access API (optional).
- Can I use it without ZIP? Yes - the Lite fallback supports one-by-one downloads.
- Copy CSV button doesn't work? Clipboard permissions vary on `file://`; Lite falls back to a textarea so you can Ctrl+C manually.
