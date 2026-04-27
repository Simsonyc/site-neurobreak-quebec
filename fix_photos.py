import glob, re

IMG_A  = '<img src="/assets/christophe.jpg" alt="Christophe Simon" style="width:100%;height:100%;object-fit:cover;object-position:center center;" />'
IMG_E1 = '<img src="/assets/christophe-simon.jpg" alt="Christophe Simon" style="width:100%;height:100%;object-fit:cover;object-position:top center;" />'
IMG_E2 = '<img src="/assets/olivier.jpg" alt="Olivier" style="width:100%;height:100%;object-fit:cover;object-position:top center;" />'
IMG_E3 = '<img src="/assets/lounas.jpg" alt="Lounas" style="width:100%;height:100%;object-fit:cover;object-position:top center;" />'

ok = 0
for f in glob.glob('*/index.html'):
    with open(f, 'r', encoding='utf-8', errors='ignore') as fh:
        c = fh.read()

    changed = False

    # Supprimer doublons
    for img in [IMG_A, IMG_E1, IMG_E2, IMG_E3]:
        new = c.replace(img + '\n' + img, img).replace(img + img, img)
        if new != c:
            c = new
            changed = True

    # Photo EN BREF
    if 'assets/christophe.jpg' not in c and 'Emplacement photo Christophe Simon' in c:
        c = c.replace(
            'aria-label="Emplacement photo Christophe Simon" class="photo-encart">\n<div class="photo-encart__placeholder">',
            'aria-label="Emplacement photo Christophe Simon" class="photo-encart">\n' + IMG_A + '\n<div class="photo-encart__placeholder" style="display:none;">'
        )
        changed = True

    # Photo Christophe trio
    if 'assets/christophe-simon.jpg' not in c and 'aria-label="Photo Christophe Simon"' in c:
        c = c.replace(
            'aria-label="Photo Christophe Simon" class="photo-encart">\n<!-- \u2193 VOTRE <img> ICI \u2193 -->\n<div class="photo-encart__placeholder">',
            'aria-label="Photo Christophe Simon" class="photo-encart">\n<!-- \u2193 VOTRE <img> ICI \u2193 -->\n' + IMG_E1 + '\n<div class="photo-encart__placeholder" style="display:none;">'
        )
        changed = True

    # Photo Olivier
    if 'assets/olivier.jpg' not in c and 'aria-label="Photo Olivier"' in c:
        c = c.replace(
            'aria-label="Photo Olivier" class="photo-encart">\n<!-- \u2193 VOTRE <img> ICI \u2193 -->\n<div class="photo-encart__placeholder">',
            'aria-label="Photo Olivier" class="photo-encart">\n<!-- \u2193 VOTRE <img> ICI \u2193 -->\n' + IMG_E2 + '\n<div class="photo-encart__placeholder" style="display:none;">'
        )
        changed = True

    # Photo Lounas
    if 'assets/lounas.jpg' not in c and 'aria-label="Photo Lounas"' in c:
        c = c.replace(
            'aria-label="Photo Lounas" class="photo-encart">\n<!-- \u2193 VOTRE <img> ICI \u2193 -->\n<div class="photo-encart__placeholder">',
            'aria-label="Photo Lounas" class="photo-encart">\n<!-- \u2193 VOTRE <img> ICI \u2193 -->\n' + IMG_E3 + '\n<div class="photo-encart__placeholder" style="display:none;">'
        )
        changed = True

    if changed:
        with open(f, 'w', encoding='utf-8') as fh:
            fh.write(c)
        ok += 1
        print(f'OK: {f}')

print(f'\nTotal modifie: {ok} fichiers')
