# Upwork proposal template (EN)

> Purpose: copy/paste-friendly proposal for small web utility + offline-first file workflow.
> Notes:
> - Keep it short for small fixed-price jobs.
> - Replace items in [brackets].
> - Avoid promising anything you cannot verify.

---

Hi [Client name],

I can help you build a privacy-friendly, offline-first file renaming/export workflow that works in a normal browser (no installs for end users).

**What I understood**
- You need: [batch rename / export a CSV manifest / optional ZIP download / keep original files untouched]
- Constraints: [offline / no upload / Windows / needs to be reversible]

**What I will deliver**
1) A working prototype (HTML/JS) that runs locally (offline).  
2) Clear UI + validation (e.g., prevent dangerous replace rules, handle duplicate names).  
3) Export options: CSV manifest + downloads (ZIP if available, otherwise individual downloads).  
4) Short README / usage steps + acceptance checklist.

**How I will implement (high level)**
- Deterministic rename rules (no "future" data / no hidden side effects).
- Safety guards (empty replace-from, OS filename invalid chars, collision detection).
- A tiny localhost helper for browsers that restrict folder picking on file:// (optional).

**Acceptance criteria (simple)**
- Given a sample folder, the tool generates the expected new names.
- "Export CSV" matches the preview.
- Downloads work (ZIP or fallback).
- No original files are modified.

**Questions (to confirm scope)**
1) How many files (typical and worst case)?
2) Naming rules: prefix/suffix/replace/numbering/date? Any examples?
3) Output needed: CSV only, downloads only, or both?
4) Must it support subfolders, or only one folder level?

**Timeline**
- First working version: [24h / 48h / 3 days]
- Final polish + docs: [same day / next day]

If you want, I can start with a minimal MVP first (1 rename rule + CSV), then iterate.

Thanks,
[Your name]

---

## Optional add-ons (only if needed)
- Extra rename rules (regex, templates, metadata columns).
- Better packaging (GitHub Release zip + SHA256 manifest).
- Demo GIF/screenshot for handoff.

## Reference (optional)
- Open-source baseline project: https://github.com/peng1233/offline-file-organizer
- Live demo (Lite, fully offline-capable): https://peng1233.github.io/offline-file-organizer/lite/
