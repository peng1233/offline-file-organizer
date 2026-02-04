// 最小自检脚本：验证 index.html 内嵌脚本的语法可被 Node 解析（不执行，只 parse）。
// 设计目标：给 CI 用，防止无意中提交破坏页面的 JS 语法。
// 用法：node tools/self_check.js

const fs = require('fs');
const path = require('path');
const vm = require('vm');

const root = path.resolve(__dirname, '..');
const htmlPath = path.join(root, 'index.html');

function extractInlineScripts(html) {
  const scripts = [];
  const re = /<script(\s[^>]*)?>([\s\S]*?)<\/script>/gi;
  let m;
  while ((m = re.exec(html))) {
    const attrs = (m[1] || '').toLowerCase();
    if (attrs.includes('src=')) continue; // 只检查内嵌脚本
    const code = (m[2] || '').trim();
    if (!code) continue;
    scripts.push(code);
  }
  return scripts;
}

function main() {
  if (!fs.existsSync(htmlPath)) {
    console.error('SELF_CHECK_FAIL: index.html not found:', htmlPath);
    process.exit(2);
  }

  const html = fs.readFileSync(htmlPath, 'utf8');
  const scripts = extractInlineScripts(html);
  if (scripts.length === 0) {
    console.error('SELF_CHECK_FAIL: no inline <script> found in index.html');
    process.exit(3);
  }

  let ok = 0;
  for (let i = 0; i < scripts.length; i++) {
    const code = scripts[i];
    const name = `index.html:inline-script#${i + 1}`;
    try {
      // 仅做语法解析，不执行
      new vm.Script(code, { filename: name });
      ok++;
    } catch (e) {
      console.error('SELF_CHECK_FAIL:', name);
      console.error(String(e && e.stack ? e.stack : e));
      process.exit(10);
    }
  }

  console.log(`SELF_CHECK_OK: parsed ${ok}/${scripts.length} inline script(s)`);
}

main();
