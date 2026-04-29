import re, glob

LIGHTBOX_CSS = """
<style id="lightbox-css">
.lb-overlay {
  display: none; position: fixed; inset: 0; z-index: 9999;
  background: rgba(0,0,0,.92); cursor: zoom-out;
  align-items: center; justify-content: center;
}
.lb-overlay.active { display: flex; }
.lb-overlay img {
  max-width: 92vw; max-height: 92vh;
  object-fit: contain; border: 1px solid rgba(255,255,255,.1);
  animation: lb-in .2s ease;
}
@keyframes lb-in {
  from { opacity: 0; transform: scale(.96); }
  to   { opacity: 1; transform: scale(1); }
}
.lb-close {
  position: absolute; top: 1.25rem; right: 1.5rem;
  color: rgba(255,255,255,.6); font-size: 2rem; cursor: pointer;
  font-family: monospace; line-height: 1; background: none; border: none;
  transition: color .15s;
}
.lb-close:hover { color: #E63E1C; }
.zd-img { cursor: zoom-in; transition: opacity .2s; }
.zd-img:hover { opacity: .88; }
</style>
"""

LIGHTBOX_HTML = """
<div class="lb-overlay" id="lb-overlay" onclick="lbClose()">
  <button class="lb-close" onclick="lbClose()">✕</button>
  <img id="lb-img" src="" alt="" onclick="event.stopPropagation()" />
</div>
"""

LIGHTBOX_JS = """
<script id="lightbox-js">
function lbOpen(src) {
  document.getElementById('lb-img').src = src;
  document.getElementById('lb-overlay').classList.add('active');
  document.body.style.overflow = 'hidden';
}
function lbClose() {
  document.getElementById('lb-overlay').classList.remove('active');
  document.getElementById('lb-img').src = '';
  document.body.style.overflow = '';
}
document.addEventListener('keydown', function(e) {
  if (e.key === 'Escape') lbClose();
});
</script>
"""

ok = 0
for f in glob.glob('*/index.html'):
    with open(f, 'r', encoding='utf-8', errors='ignore') as fh:
        c = fh.read()
    c = c.replace('\r\n', '\n')
    changed = False

    # 1 — Injecter CSS si absent
    if 'lightbox-css' not in c:
        c = c.replace('</head>', LIGHTBOX_CSS + '</head>', 1)
        changed = True

    # 2 — Injecter overlay HTML si absent
    if 'lb-overlay' not in c:
        c = c.replace('<body', LIGHTBOX_HTML + '\n<body', 1)
        changed = True

    # 3 — Injecter JS si absent
    if 'lightbox-js' not in c:
        c = c.replace('</body>', LIGHTBOX_JS + '\n</body>', 1)
        changed = True

    # 4 — Ajouter onclick sur les img Zone D uniquement
    # Pattern : img qui se trouve après un badge "Zone D"
    # On cherche les photo-encart__placeholder avec badge Zone D
    # et on ajoute onclick sur l'img juste avant ce placeholder

    def add_lightbox_to_zone_d(content):
        # Trouver tous les blocs Zone D : photo-encart contenant badge Zone D
        # et récupérer l'img qui précède le placeholder
        pattern = r'(<img[^>]*src="(/assets/[^"]+)"[^>]*)(\s*/>)(\s*\n\s*<div class="photo-encart__placeholder[^"]*">\s*\n\s*<span class="photo-encart__badge">Zone D)'
        def replacer(m):
            img_tag = m.group(1)
            src = m.group(2)
            closing = m.group(3)
            rest = m.group(4)
            # Ajouter classe et onclick si pas déjà présents
            if 'zd-img' not in img_tag:
                img_tag = img_tag + f' class="zd-img" onclick="lbOpen(\'{src}\')"'
            return img_tag + closing + rest
        return re.sub(pattern, replacer, content)

    new_c = add_lightbox_to_zone_d(c)
    if new_c != c:
        c = new_c
        changed = True

    if changed:
        with open(f, 'w', encoding='utf-8') as fh:
            fh.write(c)
        ok += 1
        print(f'OK: {f}')

print(f'\nTotal: {ok} fichiers modifiés')
