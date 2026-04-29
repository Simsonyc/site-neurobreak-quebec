import re

PAGES = {
    "automatisation-marketing-pme": {
        "photo": "automatisation-marketing-pme-territoire.png",
        "labels": ["Photo mécanique automatisation", "Photo mécanique", "Photo automatisation"],
    },
    "contenu-youtube-b2b-convertir": {
        "photo": "contenu-youtube-b2b-convertir-territoire.png",
        "labels": ["Photo formats YouTube", "Photo formats", "Photo YouTube", "Photo contenu"],
    },
    "crm-pme-b2b-quebec": {
        "photo": "crm-pme-b2b-quebec-territoire.png",
        "labels": ["Photo pipeline B2B", "Photo pipeline", "Photo CRM", "Photo crm"],
    },
    "cycle-de-vente-b2b-accelerer": {
        "photo": "cycle-de-vente-b2b-accelerer-territoire.png",
        "labels": ["Photo freins cycle", "Photo freins", "Photo cycle", "Photo vente"],
    },
    "diagnostic-marketing-pme": {
        "photo": "diagnostic-marketing-pme-territoire.png",
        "labels": ["Photo blocages B2B", "Photo blocages", "Photo diagnostic"],
    },
    "nurturing-b2b-francophone": {
        "photo": "nurturing-b2b-francophone-territoire.png",
        "labels": ["Photo codes nurturing", "Photo nurturing", "Photo codes"],
    },
    "qualification-leads-b2b": {
        "photo": "qualification-leads-b2b-territoire.png",
        "labels": ["Photo pipeline B2B structuré", "Photo pipeline structuré", "Photo qualification"],
    },
    "tableau-de-bord-marketing-b2b": {
        "photo": "tableau-de-bord-marketing-b2b-territoire.png",
        "labels": ["Photo métriques B2B", "Photo métriques", "Photo tableau", "Photo dashboard"],
    },
    "marketing-fragmente-pme": {
        "photo": "marketing-fragmente-pme-territoire.png",
        "labels": ["Photo territoire", "Photo marketing fragmenté", "Photo fragmente"],
    },
    "chaine-youtube-b2b-generation-leads": {
        "photo": "chaine-youtube-b2b-generation-leads-territoire.png",
        "labels": ["Photo chaîne YouTube", "Photo chaine YouTube", "Photo YouTube B2B"],
    },
    "reduction-cycle-vente-b2b": {
        "photo": "reduction-cycle-vente-b2b-territoire.png",
        "labels": ["Photo freins du cycle", "Photo freins cycle B2B", "Photo réduction cycle"],
    },
    "systeme-marketing-centralise-pme": {
        "photo": "systeme-marketing-centralise-pme-territoire.png",
        "labels": ["Emplacement photo système orchestré", "Photo système orchestré", "Photo Tableau de bord pilotage"],
    },
    "systeme-marketing-b2b-quebec": {
        "photo": "systeme-marketing-b2b-quebec-territoire.png",
        "labels": ["Photo marché québécois", "Photo québécois", "Photo système B2B"],
    },
}

STYLE = "width:100%;height:100%;object-fit:cover;object-position:center center;"
ok = 0

for folder, cfg in PAGES.items():
    f = f"{folder}/index.html"
    try:
        with open(f, 'r', encoding='utf-8', errors='ignore') as fh:
            c = fh.read()
    except:
        print(f"ABSENT: {folder}")
        continue

    c = c.replace('\r\n', '\n')
    photo = cfg["photo"]

    if f'/assets/{photo}' in c:
        print(f"DEJA OK: {folder}")
        continue

    IMG = f'<img src="/assets/{photo}" alt="" style="{STYLE}" />'
    changed = False

    # Essayer chaque label connu
    for label in cfg["labels"]:
        pattern = r'(<div[^>]*aria-label="' + re.escape(label) + r'"[^>]*>)\s*(<div class="photo-encart__placeholder"[^>]*>)'
        new = re.sub(pattern, r'\1\n' + IMG + r'\n\2', c)
        if new != c:
            c = new
            changed = True
            print(f"OK [{label}]: {folder}")
            break

    # Fallback — chercher le 2e aria-label photo (Zone D) qui n'a pas encore d'img
    if not changed:
        # Trouver tous les divs photo-encart sans img enfant
        matches = list(re.finditer(
            r'<div[^>]*aria-label="(?!Emplacement photo Christophe|Photo Christophe|Photo Olivier|Photo Lounas|Photo contextuelle|Emplacement photo contextuelle)[^"]*"[^>]*>\s*<div class="photo-encart__placeholder"',
            c
        ))
        if matches:
            m = matches[0]
            insert_pos = m.end() - len('<div class="photo-encart__placeholder"')
            c = c[:insert_pos] + IMG + '\n' + c[insert_pos:]
            changed = True
            print(f"OK [fallback]: {folder}")

    if changed:
        with open(f, 'w', encoding='utf-8') as fh:
            fh.write(c)
        ok += 1
    elif not changed:
        print(f"NON TRAITE: {folder}")

print(f"\nTotal: {ok} fichiers modifiés")
