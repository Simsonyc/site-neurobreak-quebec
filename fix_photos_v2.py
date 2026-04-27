import glob, re

IMG_A  = '<img src="/assets/christophe.jpg" alt="Christophe Simon" style="width:100%;height:100%;object-fit:cover;object-position:center center;" />'
IMG_E1 = '<img src="/assets/christophe-simon.jpg" alt="Christophe Simon" style="width:100%;height:100%;object-fit:cover;object-position:top center;" />'
IMG_E2 = '<img src="/assets/olivier.jpg" alt="Olivier" style="width:100%;height:100%;object-fit:cover;object-position:top center;" />'
IMG_E3 = '<img src="/assets/lounas.jpg" alt="Lounas" style="width:100%;height:100%;object-fit:cover;object-position:top center;" />'

# Patterns Zone A (EN BREF) - format ancien avec commentaire multi-ligne
ZONE_A_PATTERNS = [
    # Format 1 : commentaire multi-ligne
    (
        '      <div class="photo-encart" aria-label="Emplacement photo Christophe Simon">\n        <!-- \u2193 VOTRE <img> ICI \u2193\n             <img src="christophe-simon.jpg"\n                  alt="Christophe Simon \u2014 Architecte strat\xe9gique NeuroBreak\u2122"\n                  style="width:100%;height:100%;object-fit:cover;object-position:top center;" />\n             FORMAT : portrait 3/4, min. 480\xd7640 px -->\n        <div class="photo-encart__placeholder">',
        '      <div class="photo-encart" aria-label="Emplacement photo Christophe Simon">\n        ' + IMG_A + '\n        <div class="photo-encart__placeholder" style="display:none;">'
    ),
    # Format 2 : commentaire simple
    (
        '<div class="photo-encart" aria-label="Emplacement photo Christophe Simon">\n<!-- \u2193 VOTRE <img> ICI \u2193 -->\n<div class="photo-encart__placeholder">',
        '<div class="photo-encart" aria-label="Emplacement photo Christophe Simon">\n' + IMG_A + '\n<div class="photo-encart__placeholder" style="display:none;">'
    ),
]

# Patterns Zone E1 (Christophe trio)
ZONE_E1_PATTERNS = [
    (
        '        <div class="photo-encart" aria-label="Photo Christophe Simon">\n          <!-- \u2193 <img src="christophe.jpg" alt="Christophe Simon" style="width:100%;height:100%;object-fit:cover;object-position:top center;" /> \u2193 -->\n          <div class="photo-encart__placeholder">',
        '        <div class="photo-encart" aria-label="Photo Christophe Simon">\n          ' + IMG_E1 + '\n          <div class="photo-encart__placeholder" style="display:none;">'
    ),
    (
        '<div class="photo-encart" aria-label="Photo Christophe Simon">\n<!-- \u2193 VOTRE <img> ICI \u2193 -->\n<div class="photo-encart__placeholder">',
        '<div class="photo-encart" aria-label="Photo Christophe Simon">\n' + IMG_E1 + '\n<div class="photo-encart__placeholder" style="display:none;">'
    ),
]

# Patterns Zone E2 (Olivier)
ZONE_E2_PATTERNS = [
    (
        '        <div class="photo-encart" aria-label="Photo Olivier">\n          <!-- \u2193 <img src="olivier.jpg" alt="Olivier" style="width:100%;height:100%;object-fit:cover;object-position:top center;" /> \u2193 -->\n          <div class="photo-encart__placeholder">',
        '        <div class="photo-encart" aria-label="Photo Olivier">\n          ' + IMG_E2 + '\n          <div class="photo-encart__placeholder" style="display:none;">'
    ),
    (
        '<div class="photo-encart" aria-label="Photo Olivier">\n<!-- \u2193 VOTRE <img> ICI \u2193 -->\n<div class="photo-encart__placeholder">',
        '<div class="photo-encart" aria-label="Photo Olivier">\n' + IMG_E2 + '\n<div class="photo-encart__placeholder" style="display:none;">'
    ),
]

# Patterns Zone E3 (Lounas)
ZONE_E3_PATTERNS = [
    (
        '        <div class="photo-encart" aria-label="Photo Lounas">\n          <!-- \u2193 <img src="lounas.jpg" alt="Lounas" style="width:100%;height:100%;object-fit:cover;object-position:top center;" /> \u2193 -->\n          <div class="photo-encart__placeholder">',
        '        <div class="photo-encart" aria-label="Photo Lounas">\n          ' + IMG_E3 + '\n          <div class="photo-encart__placeholder" style="display:none;">'
    ),
    (
        '<div class="photo-encart" aria-label="Photo Lounas">\n<!-- \u2193 VOTRE <img> ICI \u2193 -->\n<div class="photo-encart__placeholder">',
        '<div class="photo-encart" aria-label="Photo Lounas">\n' + IMG_E3 + '\n<div class="photo-encart__placeholder" style="display:none;">'
    ),
]

ALL_PATTERNS = [
    ('christophe.jpg', ZONE_A_PATTERNS),
    ('christophe-simon.jpg', ZONE_E1_PATTERNS),
    ('olivier.jpg', ZONE_E2_PATTERNS),
    ('lounas.jpg', ZONE_E3_PATTERNS),
]

ok = 0
for f in glob.glob('*/index.html'):
    with open(f, 'r', encoding='utf-8', errors='ignore') as fh:
        c = fh.read()
    
    # Normaliser fins de ligne
    c = c.replace('\r\n', '\n')
    changed = False

    # Supprimer doublons
    for img in [IMG_A, IMG_E1, IMG_E2, IMG_E3]:
        new = c.replace(img + '\n' + img, img).replace(img + img, img)
        if new != c:
            c = new
            changed = True

    # Appliquer les corrections
    for asset, patterns in ALL_PATTERNS:
        if asset not in c:
            for old, new in patterns:
                if old in c:
                    c = c.replace(old, new)
                    changed = True
                    break

    if changed:
        with open(f, 'w', encoding='utf-8') as fh:
            fh.write(c)
        ok += 1
        print(f'OK: {f}')

print(f'\nTotal modifie: {ok} fichiers')
