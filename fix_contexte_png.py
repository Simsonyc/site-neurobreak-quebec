#!/usr/bin/env python3
"""
fix_contexte_png.py
Corrige la casse .PNG -> .png sur les balises contexte Zone B
uniquement sur les 13 pages secondaires.
Lancer depuis la racine du site : python fix_contexte_png.py
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

def fix(page: str) -> str:
    file = Path(page) / "index.html"
    if not file.exists():
        return f"⚠️  introuvable : {file}"

    html = file.read_text(encoding="utf-8")
    old = f"{page}-contexte.PNG"
    new = f"{page}-contexte.png"

    if old not in html:
        if new in html:
            return f"⏭️  déjà en .png : {page}"
        return f"❌  aucune référence contexte trouvée : {page}"

    html = html.replace(old, new)
    file.write_text(html, encoding="utf-8")
    return f"✅  corrigé : {page}"


if __name__ == "__main__":
    print("=== fix_contexte_png.py — NeuroBreak™ ===\n")
    for page in PAGES:
        print(fix(page))
    print("\nTerminé.")
