import re, glob

SECONDAIRES = {
    "automatisation-marketing-pme": {
        "b": "automatisation-marketing-pme-contexte.PNG",
        "d": "automatisation-marketing-pme-territoire.png",
    },
    "contenu-youtube-b2b-convertir": {
        "b": "contenu-youtube-b2b-convertir-contexte.PNG",
        "d": "contenu-youtube-b2b-convertir-territoire.png",
    },
    "crm-pme-b2b-quebec": {
        "b": "crm-pme-b2b-quebec-contexte.PNG",
        "d": "crm-pme-b2b-quebec-territoire.png",
    },
    "cycle-de-vente-b2b-accelerer": {
        "b": "cycle-de-vente-b2b-accelerer-contexte.PNG",
        "d": "cycle-de-vente-b2b-accelerer-territoire.png",
    },
    "diagnostic-marketing-pme": {
        "b": "diagnostic-marketing-pme-contexte.PNG",
        "d": "diagnostic-marketing-pme-territoire.png",
    },
    "nurturing-b2b-francophone": {
        "b": "nurturing-b2b-francophone-contexte.PNG",
        "d": "nurturing-b2b-francophone-territoire.png",
    },
    "qualification-leads-b2b": {
        "b": "qualification-leads-b2b-contexte.PNG",
        "d": "qualification-leads-b2b-territoire.png",
    },
    "tableau-de-bord-marketing-b2b": {
        "b": "tableau-de-bord-marketing-b2b-contexte.PNG",
        "d": "tableau-de-bord-marketing-b2b-territoire.png",
    },
    "marketing-fragmente-pme": {
        "b": "marketing-fragmente-pme-contexte.PNG",
        "d": "marketing-fragmente-pme-territoire.png",
    },
    "chaine-youtube-b2b-generation-leads": {
        "b": "chaine-youtube-b2b-generation-leads-contexte.PNG",
        "d": "chaine-youtube-b2b-generation-leads-territoire.png",
    },
    "reduction-cycle-vente-b2b": {
        "b": "reduction-cycle-vente-b2b-contexte.PNG",
        "d": "reduction-cycle-vente-b2b-territoire.png",
    },
    "systeme-marketing-centralise-pme": {
        "b": "systeme-marketing-centralise-pme-contexte.PNG",
        "d": "systeme-marketing-centralise-pme-territoire.png",
    },
    "systeme-marketing-b2b-quebec": {
        "b": "systeme-marketing-b2b-quebec-contexte.PNG",
        "d": "systeme-marketing-b2b-quebec-territoire.png",
    },
}

STYLE = "width:100%;height:100%;object-fit:cover;object-position:center center;"

ok = 0
for folder, photos in SECONDAIRES.items():
    f = f"{folder}/index.html"
    try:
        with open(f, 'r', encoding='utf-8', errors='ignore') as fh:
            c = fh.read()
    except:
        print(f"ABSENT: {folder}")
        continue

    c = c.replace('\r\n', '\n')
    changed = False

    # ── Zone B ──────────────────────────────────────────────────────────────────
    photo_b = photos["b"]
    IMG_B = f'<img src="/assets/{photo_b}" alt="" style="{STYLE}" />'

    if f'/assets/{photo_b}' not in c:
        # Supprimer ancienne img contexte mal injectée
        c = re.sub(r'<img src="/assets/[^"]*-contexte\.[^"]*"[^/]*/>\n?', '', c)

        patterns_b = [
            r'(<div[^>]*aria-label="[^"]*[Cc]ontextuelle[^"]*"[^>]*>)\n\n(<div class="photo-encart__placeholder"[^>]*>)',
            r'(<div[^>]*aria-label="[^"]*[Cc]ontextuelle[^"]*"[^>]*>)\n(<div class="photo-encart__placeholder"[^>]*>)',
            r'(<div[^>]*aria-label="[^"]*[Cc]ontexte[^"]*"[^>]*>)\n\n(<div class="photo-encart__placeholder"[^>]*>)',
            r'(<div[^>]*aria-label="[^"]*[Cc]ontexte[^"]*"[^>]*>)\n(<div class="photo-encart__placeholder"[^>]*>)',
            r'(<div class="photo-encart" aria-label="Emplacement photo contextuelle">)\n<!-- ↓ VOTRE <img> ICI ↓ -->\n(<div class="photo-encart__placeholder">)',
            r'(<div class="photo-encart" aria-label="Emplacement photo contextuelle">)\n(<div class="photo-encart__placeholder">)',
        ]
        for p in patterns_b:
            new = re.sub(p, r'\1\n' + IMG_B + r'\n\2', c)
            if new != c:
                c = new
                changed = True
                break

    # ── Zone D ──────────────────────────────────────────────────────────────────
    photo_d = photos["d"]
    IMG_D = f'<img src="/assets/{photo_d}" alt="" style="{STYLE}" />'

    if f'/assets/{photo_d}' not in c:
        patterns_d = [
            # aria-label contenant territoire, systeme, pipeline, orchestr, pilotage
            r'(<div[^>]*aria-label="[^"]*territoire[^"]*"[^>]*>)\s*(<div class="photo-encart__placeholder"[^>]*>)',
            r'(<div[^>]*aria-label="[^"]*[Ss]yst[^"]*me[^"]*"[^>]*>)\s*(<div class="photo-encart__placeholder"[^>]*>)',
            r'(<div[^>]*aria-label="[^"]*[Pp]ipeline[^"]*"[^>]*>)\s*(<div class="photo-encart__placeholder"[^>]*>)',
            r'(<div[^>]*aria-label="[^"]*[Oo]rchest[^"]*"[^>]*>)\s*(<div class="photo-encart__placeholder"[^>]*>)',
            r'(<div[^>]*aria-label="[^"]*[Pp]ilotage[^"]*"[^>]*>)\s*(<div class="photo-encart__placeholder"[^>]*>)',
            r'(<div[^>]*aria-label="[^"]*[Tt]ableau[^"]*"[^>]*>)\s*(<div class="photo-encart__placeholder"[^>]*>)',
            r'(<div[^>]*aria-label="[^"]*[Mm]arch[^"]*"[^>]*>)\s*(<div class="photo-encart__placeholder"[^>]*>)',
            # Fallback : tout Emplacement photo restant
            r'(<div[^>]*aria-label="Emplacement photo[^"]*"[^>]*>)\s*(<div class="photo-encart__placeholder"[^>]*>)',
            r'(<div[^>]*aria-label="Emplacement photo[^"]*"[^>]*>)\n<!-- ↓ VOTRE <img> ICI ↓ -->\n(<div class="photo-encart__placeholder">)',
        ]
        for p in patterns_d:
            new = re.sub(p, r'\1\n' + IMG_D + r'\n\2', c)
            if new != c:
                c = new
                changed = True
                break

    if changed:
        with open(f, 'w', encoding='utf-8') as fh:
            fh.write(c)
        ok += 1
        print(f"OK: {folder} — B:{c.count(photo_b)} D:{c.count(photo_d)}")
    else:
        print(f"DEJA OK ou NON TRAITE: {folder}")

print(f"\nTotal: {ok} fichiers modifiés")
