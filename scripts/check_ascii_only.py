#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Check copy/paste safety for marketplace text templates.

We *fail* only on characters that frequently break copy/paste or indicate
encoding corruption:
- U+FFFD (replacement char)
- U+00A0 (NBSP)
- U+200B/U+200C/U+200D (zero-width)
- U+FEFF (BOM inside text)

We *warn* (non-fatal) on other non-ASCII characters like smart quotes or em dashes.
"""

from __future__ import annotations

import argparse
import glob
import os
import sys


def iter_files(paths: list[str], globs: list[str]) -> list[str]:
    out: list[str] = []
    for p in paths:
        if not p:
            continue
        out.append(p)
    for g in globs:
        if not g:
            continue
        out.extend(glob.glob(g, recursive=True))

    # normalize + de-dup while preserving order
    seen = set()
    normalized: list[str] = []
    for p in out:
        ap = os.path.normpath(p)
        if ap in seen:
            continue
        seen.add(ap)
        normalized.append(ap)
    return normalized


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--paths", nargs="*", default=[], help="explicit file paths")
    ap.add_argument("--glob", nargs="*", default=[], help="glob patterns")
    args = ap.parse_args()

    files = iter_files(args.paths, args.glob)
    files = [p for p in files if os.path.isfile(p)]

    if not files:
        print("WARN: no files matched", file=sys.stdout)
        return 0

    bad = 0
    warn = 0
    scanned = 0

    fatal_set = {
        "\ufffd",  # replacement char
        "\u00a0",  # nbsp
        "\u200b", "\u200c", "\u200d",  # zero-width
        "\ufeff",  # bom in text
    }

    for path in files:
        scanned += 1
        # Read as UTF-8, but tolerate BOM.
        with open(path, "rb") as f:
            raw = f.read()
        if raw.startswith(b"\xef\xbb\xbf"):
            raw = raw[3:]
        try:
            text = raw.decode("utf-8")
        except UnicodeDecodeError as e:
            print(f"FAIL: utf-8 decode error: {path}: {e}")
            bad += 1
            continue

        # Keep line/col for debuggability
        line = 1
        col = 0
        for ch in text:
            if ch == "\n":
                line += 1
                col = 0
                continue
            col += 1
            o = ord(ch)
            if o <= 127:
                continue
            # ignore CR just in case
            if ch == "\r":
                continue

            code = f"U+{o:04X}"
            # avoid Windows console encoding issues (e.g. GBK): print escaped snippet
            snippet = ch.encode("unicode_escape").decode("ascii")

            if ch in fatal_set:
                print(f"FATAL_CHAR: {path}:{line}:{col} {code} '{snippet}'")
                bad += 1
            else:
                print(f"WARN_NON_ASCII: {path}:{line}:{col} {code} '{snippet}'")
                warn += 1

            # don't spam
            if bad + warn >= 200:
                print("NOTE: too many findings (output capped at 200)")
                return 1 if bad else 0

    if bad == 0:
        if warn == 0:
            print(f"OK: paste-safety scan passed (files scanned: {scanned})")
        else:
            print(f"OK: paste-safety scan passed (files scanned: {scanned}); warnings(non-ascii)={warn}")
        return 0

    print(f"FAIL: found fatal characters (count: {bad}); warnings(non-ascii)={warn}")
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
