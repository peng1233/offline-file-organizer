// 最小自检：校验文件名安全处理与替换模式校验
// 运行：node selfcheck.js

function sanitizeFilename(name){
  const replaced = String(name)
    .replace(/[\u0000-\u001F\u007F]/g, '_')
    .replace(/[\\\/\:\*\?\"\<\>\|]/g, '_')
    .replace(/[\.\s]+$/g, '');
  return replaced || 'file';
}

function calcNewName({name}, i, opts){
  const mode = opts.mode;
  const prefix = sanitizeFilename((opts.prefix||'').trim());
  const sep = opts.sep ?? '';
  const start = parseInt(opts.start||'1',10);
  const pad = Math.max(0, Math.min(8, parseInt(opts.pad||'0',10)));

  const dot = name.lastIndexOf('.');
  const base = dot>0 ? name.slice(0,dot) : name;
  const ext = dot>0 ? name.slice(dot) : '';
  const idx = start + i;
  const padNum = (n,w)=>{ const s=String(n); return s.length>=w? s : ('0'.repeat(w-s.length)+s); };

  let out;
  if(mode==='prefix-index') out = `${prefix}${sep}${padNum(idx,pad)}${ext}`;
  else if(mode==='keepname-prefix') out = `${prefix}${sep}${base}${ext}`;
  else if(mode==='replace') out = `${base.replaceAll(opts.from, opts.to)}${ext}`;
  else out = name;

  return sanitizeFilename(out);
}

function assert(cond, msg){
  if(!cond) throw new Error('ASSERT_FAIL: ' + msg);
}

// --- tests ---
assert(sanitizeFilename('a<b>.txt')==='a_b_.txt', '非法字符替换');
assert(sanitizeFilename('abc.  ')==='abc', '尾部点/空格移除');
assert(sanitizeFilename('')==='file', '空名兜底');

const n1 = calcNewName({name:'x?.png'}, 0, {mode:'prefix-index', prefix:'IMG', sep:'_', start:1, pad:3});
assert(n1==='IMG_001.png', 'prefix-index 生成');

const n2 = calcNewName({name:'hello.txt'}, 0, {mode:'keepname-prefix', prefix:'P', sep:'-', start:1, pad:0});
assert(n2==='P-hello.txt', 'keepname-prefix 生成');

const n3 = calcNewName({name:'ababa.txt'}, 0, {mode:'replace', prefix:'', sep:'_', start:1, pad:0, from:'aba', to:'X'});
assert(n3==='Xba.txt', 'replace 生成');

console.log('SELF_CHECK_OK');
