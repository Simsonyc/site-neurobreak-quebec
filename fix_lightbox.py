import re, glob

ok = 0
for f in glob.glob('*/index.html'):
    with open(f, 'r', encoding='utf-8', errors='ignore') as fh:
        c = fh.read()
    c = c.replace('\r\n', '\n')
    changed = False

    # 1 — Retirer class="zd-img" et onclick="lbOpen(...)" de TOUTES les images
    # puis on réinjecte uniquement sur les bonnes
    old_c = c
    c = re.sub(r' class="zd-img" onclick="lbOpen\(\'[^\']*\'\)"', '', c)
    if c != old_c:
        changed = True

    # 2 — Réinjecter lightbox UNIQUEMENT sur les img Zone D
    # Zone D = img qui est immédiatement suivie d'un placeholder avec badge "Zone D"
    # Pattern exact : img src ... /> \n <div class="photo-encart__placeholder..."> \n <span ...>Zone D
    def add_zd(content):
        pattern = r'(<img)([^>]*src="(/assets/[^"]+)"[^>]*)(/>)(\s*\n\s*<div class="photo-encart__placeholder[^>]*>\s*\n\s*<span class="photo-encart__badge">Zone D)'
        def replacer(m):
            tag_start = m.group(1)
            attrs = m.group(2)
            src = m.group(3)
            closing = m.group(4)
            rest = m.group(5)
            return f'{tag_start}{attrs} class="zd-img" onclick="lbOpen(\'{src}\')" {closing}{rest}'
        return re.sub(pattern, replacer, content, flags=re.DOTALL)

    new_c = add_zd(c)
    if new_c != c:
        c = new_c
        changed = True

    if changed:
        with open(f, 'w', encoding='utf-8') as fh:
            fh.write(c)
        ok += 1
        # Compter combien de Zone D ont été traitées
        count = c.count('class="zd-img"')
        print(f'OK: {f} — {count} Zone D')

print(f'\nTotal: {ok} fichiers modifiés')
