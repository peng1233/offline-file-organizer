/*
  Make a small demo GIF (no manual recording) from existing PNG screenshots.
  - Input: docs/assets/*.png
  - Output: docs/assets/lite-demo.gif

  Why:
  - Produces a shareable animation for Upwork/Fiverr/Toptal/Sponsors.
  - Avoids requiring manual screen recording for the first GIF asset.

  Usage:
    node tools/make_demo_gif_from_pngs.js

  Notes:
  - Frames may have different sizes; we crop to the smallest common WxH from top-left.
*/

const fs = require('node:fs');
const path = require('node:path');

const { PNG } = require('pngjs');
const { GIFEncoder, quantize, applyPalette } = require('gifenc');

function readPng(p) {
  const buf = fs.readFileSync(p);
  const png = PNG.sync.read(buf);
  return png;
}

function cropRgba(png, w, h) {
  if (png.width === w && png.height === h) return png.data;
  const out = Buffer.alloc(w * h * 4);
  for (let y = 0; y < h; y++) {
    const srcRowStart = (y * png.width) * 4;
    const dstRowStart = (y * w) * 4;
    png.data.copy(out, dstRowStart, srcRowStart, srcRowStart + w * 4);
  }
  return out;
}

function ensureDir(p) {
  fs.mkdirSync(p, { recursive: true });
}

function main() {
  const repoRoot = path.resolve(__dirname, '..');

  const inputs = [
    path.join(repoRoot, 'docs', 'assets', 'lite-home-v10.png'),
    path.join(repoRoot, 'docs', 'assets', 'lite-after-run.png'),
    path.join(repoRoot, 'docs', 'assets', 'lite-copy-csv.png'),
  ];

  const missing = inputs.filter(p => !fs.existsSync(p));
  if (missing.length) {
    console.error('FAIL: missing input file(s):');
    for (const p of missing) console.error(' - ' + p);
    process.exit(2);
  }

  const pngs = inputs.map(readPng);
  const w = Math.min(...pngs.map(p => p.width));
  const h = Math.min(...pngs.map(p => p.height));

  const framesRgba = pngs.map(p => cropRgba(p, w, h));

  // Quantize palette from all frames.
  const allPixels = Buffer.concat(framesRgba);
  const palette = quantize(allPixels, 256);

  const encoder = GIFEncoder();
  encoder.writeHeader();

  const delaysMs = [650, 650, 900];
  for (let i = 0; i < framesRgba.length; i++) {
    const rgba = framesRgba[i];
    const indexed = applyPalette(rgba, palette);
    encoder.writeFrame(indexed, w, h, {
      // gifenc expects centiseconds.
      delay: Math.round((delaysMs[i] ?? 700) / 10),
      repeat: 0,
      // Required for first frame.
      palette,
    });
  }

  encoder.finish();
  const gif = Buffer.from(encoder.bytes());

  const outDir = path.join(repoRoot, 'docs', 'assets');
  ensureDir(outDir);
  const outPath = path.join(outDir, 'lite-demo.gif');
  fs.writeFileSync(outPath, gif);

  console.log(`OK: wrote ${path.relative(repoRoot, outPath)} (${gif.length} bytes), size=${w}x${h}, frames=${framesRgba.length}`);
}

main();
