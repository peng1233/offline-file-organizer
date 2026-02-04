#!/usr/bin/env node
/*
  Minimal static server for offline-file-organizer.
  Why: Some browser APIs (e.g. showDirectoryPicker / File System Access API)
  require a secure context. `http://localhost` qualifies, while `file://` often doesn't.

  Usage:
    node tools/serve.js
    node tools/serve.js --port 5173
    node tools/serve.js --no-open

  No dependencies.
*/

const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');
const child_process = require('child_process');

function parseArgs(argv) {
  const out = { port: 5173, open: true };
  for (let i = 2; i < argv.length; i++) {
    const a = argv[i];
    if (a === '--no-open') out.open = false;
    else if (a === '--open') out.open = true;
    else if (a === '--port') {
      const v = argv[i + 1];
      if (!v) throw new Error('Missing value for --port');
      out.port = Number(v);
      i++;
    } else if (a.startsWith('--port=')) {
      out.port = Number(a.split('=')[1]);
    } else if (a === '--help' || a === '-h') {
      out.help = true;
    } else {
      // ignore unknown args to keep it forgiving
    }
  }
  if (!Number.isFinite(out.port) || out.port <= 0 || out.port > 65535) {
    throw new Error('Invalid port. Use 1-65535');
  }
  return out;
}

function contentTypeFor(filePath) {
  const ext = path.extname(filePath).toLowerCase();
  switch (ext) {
    case '.html': return 'text/html; charset=utf-8';
    case '.js': return 'text/javascript; charset=utf-8';
    case '.mjs': return 'text/javascript; charset=utf-8';
    case '.css': return 'text/css; charset=utf-8';
    case '.png': return 'image/png';
    case '.jpg':
    case '.jpeg': return 'image/jpeg';
    case '.gif': return 'image/gif';
    case '.svg': return 'image/svg+xml';
    case '.txt': return 'text/plain; charset=utf-8';
    case '.md': return 'text/markdown; charset=utf-8';
    case '.json': return 'application/json; charset=utf-8';
    case '.zip': return 'application/zip';
    default: return 'application/octet-stream';
  }
}

function safeResolve(rootDir, requestPathname) {
  const decoded = decodeURIComponent(requestPathname);
  // Normalize and prevent path traversal
  const cleaned = decoded.replace(/\0/g, '');
  const joined = path.join(rootDir, cleaned);
  const resolved = path.resolve(joined);
  const rootResolved = path.resolve(rootDir);
  if (!resolved.startsWith(rootResolved)) return null;
  return resolved;
}

function tryOpen(urlToOpen) {
  try {
    // Windows: `start` is a built-in of cmd.
    child_process.exec(`cmd /c start "" "${urlToOpen}"`);
  } catch (_) {
    // ignore
  }
}

async function main() {
  const args = parseArgs(process.argv);
  if (args.help) {
    console.log('Usage: node tools/serve.js [--port 5173] [--no-open]');
    process.exit(0);
  }

  const rootDir = path.resolve(__dirname, '..');

  const server = http.createServer((req, res) => {
    const u = url.parse(req.url || '/');
    let pathname = u.pathname || '/';

    if (pathname === '/') pathname = '/index.html';
    // Convenience: /lite -> /lite/
    if (pathname === '/lite') {
      res.statusCode = 302;
      res.setHeader('Location', '/lite/');
      res.end();
      return;
    }
    if (pathname === '/lite/') pathname = '/lite/index.html';

    const filePath = safeResolve(rootDir, pathname);
    if (!filePath) {
      res.statusCode = 400;
      res.setHeader('Content-Type', 'text/plain; charset=utf-8');
      res.end('Bad request');
      return;
    }

    fs.stat(filePath, (err, st) => {
      if (err || !st.isFile()) {
        res.statusCode = 404;
        res.setHeader('Content-Type', 'text/plain; charset=utf-8');
        res.end('Not found');
        return;
      }

      res.statusCode = 200;
      res.setHeader('Content-Type', contentTypeFor(filePath));
      res.setHeader('Cache-Control', 'no-store');

      const stream = fs.createReadStream(filePath);
      stream.on('error', () => {
        res.statusCode = 500;
        res.setHeader('Content-Type', 'text/plain; charset=utf-8');
        res.end('Internal error');
      });
      stream.pipe(res);
    });
  });

  await new Promise((resolve) => server.listen(args.port, '127.0.0.1', resolve));

  const mainUrl = `http://127.0.0.1:${args.port}/`;
  const liteUrl = `http://127.0.0.1:${args.port}/lite/`;

  console.log('offline-file-organizer local server is running:');
  console.log('  Main:', mainUrl);
  console.log('  Lite:', liteUrl);
  console.log('Tip: Use localhost to enable File System Access APIs in supported browsers.');
  console.log('Press Ctrl+C to stop.');

  if (args.open) {
    tryOpen(mainUrl);
  }
}

main().catch((e) => {
  console.error('[serve] Error:', e && e.message ? e.message : e);
  process.exit(1);
});
