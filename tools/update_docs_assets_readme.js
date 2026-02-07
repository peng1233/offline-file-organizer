// Update docs/assets/README.md "Current files" section based on actual files.
// Usage: node tools/update_docs_assets_readme.js
// Goal: keep marketplace/demo asset links copy-pasteable and consistent.

const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..');
const assetsDir = path.join(root, 'docs', 'assets');
const readmePath = path.join(assetsDir, 'README.md');

const RAW_BASE = process.env.RAW_BASE || 'https://raw.githubusercontent.com/peng1233/offline-file-organizer/main';

function listAssetFiles() {
  if (!fs.existsSync(assetsDir)) return [];
  return fs
    .readdirSync(assetsDir)
    .filter((name) => name && name.toLowerCase() !== 'readme.md')
    .filter((name) => {
      const full = path.join(assetsDir, name);
      try {
        return fs.statSync(full).isFile();
      } catch {
        return false;
      }
    })
    .sort((a, b) => a.localeCompare(b));
}

function buildSection(files) {
  const lines = [];
  lines.push('Current files in this folder:');
  if (files.length === 0) {
    lines.push('- (none yet)');
    return lines.join('\n') + '\n';
  }
  for (const f of files) {
    const url = `${RAW_BASE}/docs/assets/${encodeURIComponent(f).replace(/%2F/g, '/')}`;
    lines.push(`- ${f}`);
    lines.push(`  - raw: ${url}`);
  }
  return lines.join('\n') + '\n';
}

function main() {
  if (!fs.existsSync(readmePath)) {
    console.error('FAIL: docs/assets/README.md not found:', readmePath);
    process.exit(2);
  }

  const original = fs.readFileSync(readmePath, 'utf8');
  const files = listAssetFiles();

  const marker = 'Current files in this folder:';
  const idx = original.indexOf(marker);
  if (idx === -1) {
    console.error('FAIL: marker not found in README.md:', marker);
    process.exit(3);
  }

  // Replace everything from marker to EOF.
  const head = original.slice(0, idx);
  const next = head + buildSection(files);

  if (next === original) {
    console.log(`OK: no change (${files.length} file(s))`);
    return;
  }

  fs.writeFileSync(readmePath, next, 'utf8');
  console.log(`OK: updated README.md (${files.length} file(s))`);
}

main();
