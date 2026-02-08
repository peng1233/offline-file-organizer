#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Fail fast if U+FFFD (replacement char '�') appears in text assets.

Why: Some editors or copy/paste flows can introduce mojibake, and it may look fine
locally but breaks when pasted into Upwork/Fiverr/Toptal/Sponsors.

Usage:
  python scripts/check_no_replacement_char.py
  python scripts/check_no_replacement_char.py --root docs/marketplace
  python scripts/check_no_replacement_char.py --paths docs/marketplace README.md README_EN.md index.html en.html

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


def iter_target_files(targets: list[str]):
    """Yield files under given targets.

    Each target may be a file or directory. Directories are walked recursively.
    """
    for t in targets:
        if os.path.isdir(t):
            yield from iter_files(t)
        elif os.path.isfile(t):
            ext = os.path.splitext(t)[1].lower()
            if ext in DEFAULT_TEXT_EXTS:
                yield t
        else:
            # Ignore missing paths but keep it visible.
            print(f"WARN: path not found: {t}")


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
    ap.add_argument(
        "--paths",
        nargs="*",
        default=None,
        help="optional explicit file/dir paths to scan (overrides --root)",
    )
    args = ap.parse_args()

    base = os.path.abspath(".")

    found_any = False
    files_scanned = 0

    if args.paths:
        targets = [os.path.abspath(p) for p in args.paths]
        it = iter_target_files(targets)
        rel_base = base
    else:
        root = os.path.abspath(args.root)
        if not os.path.isdir(root):
            print(f"FAIL: root not found: {root}")
            return 1
        it = iter_files(root)
        rel_base = root

    for p in it:
        files_scanned += 1
        hits = scan_file(p)
        if hits:
            found_any = True
            rel = os.path.relpath(p, rel_base)
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
