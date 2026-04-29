import re, glob

ok = 0
for f in glob.glob('*/index.html'):
    with open(f, 'r', encoding='utf-8', errors='ignore') as fh:
        c = fh.read()
    c = c.replace('\r\n', '\n')
    changed = False

    # 1 — Retirer TOUS les zd-img et lbOpen existants mal placés
    old_c = c
    c = re.sub(r' class="zd-img" onclick="lbOpen\(\'[^\']*\'\)"', '', c)
    if c != old_c:
        changed = True

    # 2 — Réinjecter UNIQUEMENT sur les img Zone D
    # Le badge peut être "Zone D", "Zone D · §01", "Zone D · §02" etc.
    # Structure : <img ... /> puis <div class="photo-encart__placeholder"><span ...>Zone D
    # Peut être sur la même ligne ou sur des lignes différentes
    def add_zd(content):
        pattern = r'(<img)([^>]*src="(/assets/[^"]+territoire[^"]*)"[^>]*)(/>)'
        def replacer(m):
            tag_start = m.group(1)
            attrs = m.group(2)
            src = m.group(3)
            closing = m.group(4)
            if 'zd-img' not in attrs:
                return f'{tag_start}{attrs} class="zd-img" onclick="lbOpen(\'{src}\')" {closing}'
            return m.group(0)
        return re.sub(pattern, replacer, content)

    new_c = add_zd(c)
    if new_c != c:
        c = new_c
        changed = True

    if changed:
        with open(f, 'w', encoding='utf-8') as fh:
            fh.write(c)
        ok += 1
        count = c.count('class="zd-img"')
        print(f'OK: {f} — {count} Zone D')

print(f'\nTotal: {ok} fichiers modifiés')
