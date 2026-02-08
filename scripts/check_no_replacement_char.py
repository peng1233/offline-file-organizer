#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Fail fast if U+FFFD (replacement char '�') appears in text assets.

Why: Some editors or copy/paste flows can introduce mojibake, and it may look fine
locally but breaks when pasted into Upwork/Fiverr/Toptal/Sponsors.

Usage:
  python scripts/check_no_replacement_char.py
  python scripts/check_no_replacement_char.py --root docs/marketplace

Exit code:
  0 = OK (no U+FFFD found)
  2 = Found
"""

from __future__ import annotations

import argparse
import os
import sys

BAD = "\uFFFD"

DEFAULT_TEXT_EXTS = {
    ".md",
    ".txt",
    ".html",
    ".js",
    ".css",
    ".ps1",
    ".cmd",
    ".json",
    ".yml",
    ".yaml",
}


def iter_files(root: str):
    for dirpath, dirnames, filenames in os.walk(root):
        # Skip .git
        if ".git" in dirnames:
            dirnames.remove(".git")

        # Skip dist folders (often contains archives/bundles)
        dirnames[:] = [d for d in dirnames if d.lower() != "dist"]

        for fn in filenames:
            ext = os.path.splitext(fn)[1].lower()
            if ext not in DEFAULT_TEXT_EXTS:
                continue
            yield os.path.join(dirpath, fn)


def scan_file(path: str):
    # Read as UTF-8; replace errors so we can still detect U+FFFD.
    with open(path, "r", encoding="utf-8", errors="replace") as f:
        s = f.read()
    if BAD not in s:
        return []

    # Report line numbers for quick fix.
    hits = []
    for i, line in enumerate(s.splitlines(), start=1):
        if BAD in line:
            hits.append((i, line))
    return hits


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--root", default=".", help="root directory to scan (default: repo root)")
    args = ap.parse_args()

    root = os.path.abspath(args.root)
    if not os.path.isdir(root):
        print(f"FAIL: root not found: {root}")
        return 1

    found_any = False
    files_scanned = 0

    for p in iter_files(root):
        files_scanned += 1
        hits = scan_file(p)
        if hits:
            found_any = True
            rel = os.path.relpath(p, root)
            for (ln, line) in hits:
                # Keep output ASCII-friendly: show the line but avoid PowerShell encoding surprises.
                safe_line = line.replace("\t", " ").strip()
                print(f"FOUND {rel}:{ln}: {safe_line}")

    if found_any:
        print("FAIL: detected U+FFFD replacement character (possible mojibake)")
        return 2

    print(f"OK: no U+FFFD found (files scanned: {files_scanned})")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
