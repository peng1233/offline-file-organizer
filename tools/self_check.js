// 最小自检脚本：验证 HTML 内嵌脚本的语法可被 Node 解析（不执行，只 parse）。
// 设计目标：给 CI 用，防止无意中提交破坏页面的 JS 语法。
// 用法：node tools/self_check.js

const fs = require('fs');
const path = require('path');
const vm = require('vm');

const root = path.resolve(__dirname, '..');
const htmlFiles = ['index.html', 'en.html'];

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

function checkHtml(fileName) {
  const htmlPath = path.join(root, fileName);
  if (!fs.existsSync(htmlPath)) {
    // 兼容：有的发行版可能没有 en.html
    return { fileName, skipped: true, scripts: 0, parsed: 0 };
  }

  const html = fs.readFileSync(htmlPath, 'utf8');
  const scripts = extractInlineScripts(html);
  if (scripts.length === 0) {
    // 兼容：有的页面可能没有内嵌脚本（全部外链），这里不视为失败。
    return { fileName, skipped: true, scripts: 0, parsed: 0 };
  }

  let ok = 0;
  for (let i = 0; i < scripts.length; i++) {
    const code = scripts[i];
    const name = `${fileName}:inline-script#${i + 1}`;
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

  return { fileName, skipped: false, scripts: scripts.length, parsed: ok };
}

function main() {
  const results = htmlFiles.map(checkHtml);
  const checked = results.filter((r) => !r.skipped);
  if (checked.length === 0) {
    console.error('SELF_CHECK_FAIL: no html files found to check:', htmlFiles.join(', '));
    process.exit(2);
  }

  const parsedTotal = checked.reduce((a, r) => a + r.parsed, 0);
  const scriptTotal = checked.reduce((a, r) => a + r.scripts, 0);

  const checkedNames = checked.map((r) => r.fileName).join(', ');
  console.log(`SELF_CHECK_OK: parsed ${parsedTotal}/${scriptTotal} inline script(s) in ${checkedNames}`);
}

main();
