#!/usr/bin/env python3
"""
inject_zone_b.py
Injecte l'image Zone B (photo-inline / §01) dans chaque page NeuroBreak™.
Lancer depuis la racine du site : python inject_zone_b.py
"""

import re
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

# Regex : trouve le bloc photo-inline qui contient "Zone B"
# et qui n'a pas encore de <img> (placeholder only)
PATTERN = re.compile(
    r'(<div[^>]*class="photo-encart"[^>]*>)'   # ouverture photo-encart
    r'(\s*<!-- ↓ VOTRE <img> ICI ↓ -->)'        # commentaire placeholder
    r'(\s*<div class="photo-encart__placeholder">)'
    r'(\s*<span class="photo-encart__badge">Zone B)',
    re.DOTALL
)

def inject(page: str) -> str:
    file = Path(page) / "index.html"
    if not file.exists():
        return f"⚠️  introuvable : {file}"

    html = file.read_text(encoding="utf-8")

    # Vérifie si Zone B a déjà une img
    if re.search(
        r'<img[^>]+>\s*<div class="photo-encart__placeholder">\s*<span[^>]*>Zone B',
        html, re.DOTALL
    ):
        return f"⏭️  déjà corrigé : {page}"

    img_tag = f'<img src="/assets/{page}-contexte.png" alt="{page}" style="width:100%;height:100%;object-fit:cover;" />\n          '

    new_html, n = PATTERN.subn(
        lambda m: m.group(1) + "\n          " + img_tag + m.group(3) + m.group(4),
        html
    )

    if n == 0:
        return f"❌  pattern Zone B non trouvé : {page}"

    file.write_text(new_html, encoding="utf-8")
    return f"✅  corrigé : {page}"


if __name__ == "__main__":
    print("=== inject_zone_b.py — NeuroBreak™ ===\n")
    for page in PAGES:
        print(inject(page))
    print("\nTerminé.")
