import re, glob

# CSS lightbox
LIGHTBOX_CSS = '''<style id="lightbox-css">
#lb-overlay{display:none;position:fixed;inset:0;z-index:9999;background:rgba(0,0,0,.92);cursor:zoom-out;align-items:center;justify-content:center;}
#lb-overlay.active{display:flex;}
#lb-overlay img{max-width:92vw;max-height:92vh;object-fit:contain;border:1px solid rgba(255,255,255,.1);animation:lb-in .2s ease;}
@keyframes lb-in{from{opacity:0;transform:scale(.96);}to{opacity:1;transform:scale(1);}}
#lb-close{position:absolute;top:1.25rem;right:1.5rem;color:rgba(255,255,255,.6);font-size:2rem;cursor:pointer;font-family:monospace;line-height:1;background:none;border:none;transition:color .15s;}
#lb-close:hover{color:#E63E1C;}
.zd-img{cursor:zoom-in !important;transition:opacity .2s;}
.zd-img:hover{opacity:.88;}
</style>'''

# HTML + JS lightbox (tout en un, juste avant </body>)
LIGHTBOX_BLOCK = '''<div id="lb-overlay" onclick="lbClose()">
<button id="lb-close" onclick="event.stopPropagation();lbClose()">✕</button>
<img id="lb-img" src="" alt="" onclick="event.stopPropagation()" />
</div>
<script>
function lbOpen(src){var o=document.getElementById('lb-overlay');var i=document.getElementById('lb-img');if(!o||!i)return;i.src=src;o.classList.add('active');document.body.style.overflow='hidden';}
function lbClose(){var o=document.getElementById('lb-overlay');var i=document.getElementById('lb-img');if(!o||!i)return;o.classList.remove('active');i.src='';document.body.style.overflow='';}
document.addEventListener('keydown',function(e){if(e.key==='Escape')lbClose();});
</script>'''

ok = 0
for f in glob.glob('*/index.html'):
    with open(f, 'r', encoding='utf-8', errors='ignore') as fh:
        c = fh.read()
    c = c.replace('\r\n', '\n')
    changed = False

    # 1 — Supprimer TOUT ce qui a été injecté précédemment
    c = re.sub(r'<style id="lightbox-css">.*?</style>\n?', '', c, flags=re.DOTALL)
    c = re.sub(r'<div class="lb-overlay".*?</div>\n?', '', c, flags=re.DOTALL)
    c = re.sub(r'<div id="lb-overlay".*?</script>\n?', '', c, flags=re.DOTALL)
    c = re.sub(r'<script id="lightbox-js">.*?</script>\n?', '', c, flags=re.DOTALL)
    c = re.sub(r' class="zd-img" onclick="lbOpen\(\'[^\']*\'\)"', '', c)
    changed = True

    # 2 — Injecter CSS dans </head>
    c = c.replace('</head>', LIGHTBOX_CSS + '\n</head>', 1)

    # 3 — Injecter HTML+JS juste avant </body>
    c = c.replace('</body>', LIGHTBOX_BLOCK + '\n</body>', 1)

    # 4 — Ajouter onclick sur img territoire uniquement
    c = re.sub(
        r'(<img)([^>]*src="(/assets/[^"]*territoire[^"]*)"[^>]*)(/>)',
        lambda m: f'{m.group(1)}{m.group(2)} class="zd-img" onclick="lbOpen(\'{m.group(3)}\')" {m.group(4)}',
        c
    )

    with open(f, 'w', encoding='utf-8') as fh:
        fh.write(c)
    ok += 1
    count = c.count('class="zd-img"')
    if count > 0:
        print(f'OK: {f} — {count} Zone D')

print(f'\nTotal: {ok} fichiers modifiés')
