#!/usr/bin/env python3
"""
inject_zone_b.py
Injecte l'image Zone B (§01) uniquement sur les 13 pages secondaires.
Lancer depuis la racine du site : python inject_zone_b.py
"""

from pathlib import Path

PAGES = [
    "automatisation-marketing-pme",
    "chaine-youtube-b2b-generation-leads",
    "contenu-youtube-b2b-convertir",
    "crm-pme-b2b-quebec",
    "cycle-de-vente-b2b-accelerer",
    "diagnostic-marketing-pme",
    "marketing-fragmente-pme",
    "nurturing-b2b-francophone",
    "qualification-leads-b2b",
    "reduction-cycle-vente-b2b",
    "systeme-marketing-b2b-quebec",
    "systeme-marketing-centralise-pme",
    "tableau-de-bord-marketing-b2b",
]

IMG_TEMPLATE = '<img src="/assets/{page}-contexte.png" alt="{page}" style="width:100%;height:100%;object-fit:cover;" />'
MARKER = '<span class="photo-encart__badge">Zone B'
PLACEHOLDER = '<div class="photo-encart__placeholder">'

def inject(page: str) -> str:
    file = Path(page) / "index.html"
    if not file.exists():
        return f"⚠️  introuvable : {file}"

    html = file.read_text(encoding="utf-8")

    if MARKER not in html:
        return f"❌  marker Zone B non trouvé : {page}"

    img_tag = IMG_TEMPLATE.format(page=page)

    # Position du badge Zone B
    idx = html.index(MARKER)

    # Vérifie si l'img est déjà présente juste avant le placeholder
    avant = html[max(0, idx-300):idx]
    if 'contexte.png' in avant:
        return f"⏭️  déjà corrigé : {page}"

    # Trouve le placeholder juste avant Zone B
    pos_placeholder = html.rfind(PLACEHOLDER, 0, idx)
    if pos_placeholder == -1:
        return f"❌  placeholder non trouvé : {page}"

    # Insère l'img juste avant le placeholder
    new_html = html[:pos_placeholder] + img_tag + "\n" + html[pos_placeholder:]
    file.write_text(new_html, encoding="utf-8")
    return f"✅  corrigé : {page}"


if __name__ == "__main__":
    print("=== inject_zone_b.py — NeuroBreak™ ===\n")
    for page in PAGES:
        print(inject(page))
    print("\nTerminé.")
