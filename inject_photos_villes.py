import re, glob

MAPPING = {
    "montreal-strategie-b2b": "montreal-contexte.png",
    "quebec-optimisation-b2b": "quebec-contexte.png",
    "laval-export-b2b": "laval-contexte.png",
    "longueuil-croissance-b2b": "longueuil-contexte.png",
    "gatineau-conformite-b2b": "gatineau-contexte.png",
    "sherbrooke-traction-b2b": "sherbrooke-contexte.png",
    "trois-rivieres-conversion-b2b": "trois-rivieres-contexte.png",
    "saguenay-acquisition-b2b": "saguenay-contexte.png",
    "levis-pipeline-b2b": "levis-contexte.png",
    "drummondville-performance-b2b": "drummondville-contexte.png",
    "saint-jerome-acceleration-b2b": "saint-jerome-contexte.png",
    "rouyn-noranda-b2b": "rouyn-Noranda-contexte.png",
    "sept-iles-b2b": "sept-iles-contexte.png",
    "terrebonne-expansion-b2b": "terrebonne-contexte.png",
    "terrebonne-acquisition-b2b": "terrebonne-contexte.png",
    "blainville-orchestration-b2b": "blainville-contexte.png",
    "blainville-acquisition-b2b": "blainville-contexte.png",
    "brossard-developpement-b2b": "brossard-contexte.png",
    "repentigny-acquisition-b2b": "repentigny-contexte.png",
    "granby-systeme-b2b": "granby-contexte.png",
    "rimouski-strategie-b2b": "rimouski-contexte.png",
    "saint-hyacinthe-marketing-b2b": "saint-hyacinthe-contexte.png",
    "saint-jean-sur-richelieu-acquisition-b2b": "saint-jerome-contexte.png",
    "shawinigan-orchestration-b2b": "shawinigan-contexte.png",
    "victoriaville-orchestration-b2b": "victoriaville-contexte.png",
}

ok = 0
for folder, photo in MAPPING.items():
    f = f"{folder}/index.html"
    try:
        with open(f, 'r', encoding='utf-8', errors='ignore') as fh:
            c = fh.read()
    except:
        print(f"ABSENT: {folder}")
        continue

    c = c.replace('\r\n', '\n')

    IMG = f'<img src="/assets/{photo}" alt="{folder}" style="width:100%;height:100%;object-fit:cover;object-position:center center;" />'

    # Supprimer ancienne img contextuelle mal injectée
    c = re.sub(r'<img src="/assets/[^"]*-contexte\.[^"]*"[^/]*/>\n?', '', c)

    changed = False

    # Pattern 1 : double saut de ligne entre div et placeholder
    p1 = r'(<div class="photo-encart" aria-label="Emplacement photo contextuelle">)\n\n(<div class="photo-encart__placeholder")'
    new = re.sub(p1, r'\1\n' + IMG + r'\n\2', c)
    if new != c:
        c = new
        changed = True

    # Pattern 2 : saut de ligne simple
    if not changed:
        p2 = r'(<div class="photo-encart" aria-label="Emplacement photo contextuelle">)\n(<div class="photo-encart__placeholder")'
        new = re.sub(p2, r'\1\n' + IMG + r'\n\2', c)
        if new != c:
            c = new
            changed = True

    # Pattern 3 : placeholder déjà display:none (photo partiellement injectée)
    if not changed:
        p3 = r'(<div class="photo-encart" aria-label="Emplacement photo contextuelle">)\n(<div class="photo-encart__placeholder" style="display:none;")'
        new = re.sub(p3, r'\1\n' + IMG + r'\n\2', c)
        if new != c:
            c = new
            changed = True

    if changed:
        with open(f, 'w', encoding='utf-8') as fh:
            fh.write(c)
        ok += 1
        print(f"OK: {folder}")
    else:
        print(f"NON TRAITE: {folder}")

print(f"\nTotal: {ok} fichiers modifiés")
