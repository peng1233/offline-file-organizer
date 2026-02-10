import pathlib
p=pathlib.Path('docs/marketplace/links.md')
b=p.read_bytes()
print('bytes',len(b))
s=b.decode('utf-8',errors='replace')
print('has_replacement', '\ufffd' in s)
print('count_replacement', s.count('\ufffd'))
for i,line in enumerate(s.splitlines(),1):
    if '\ufffd' in line:
        print(i, line)
