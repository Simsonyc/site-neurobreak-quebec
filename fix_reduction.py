with open('reduction-cycle-vente-b2b/index.html', 'r', encoding='utf-8', errors='ignore') as f:
    c = f.read()
c = c.replace('\r\n', '\n')

STYLE = 'width:100%;height:100%;object-fit:cover;object-position:center center;'
photo_b = 'reduction-cycle-vente-b2b-contexte.PNG'
photo_d = 'reduction-cycle-vente-b2b-territoire.png'
IMG_B = f'<img src="/assets/{photo_b}" alt="" style="{STYLE}" />'
IMG_D = f'<img src="/assets/{photo_d}" alt="" style="{STYLE}" />'

old_b = '          <!-- \u2193 VOTRE <img> ICI \u2193 -->\n          <div class="photo-encart__placeholder">\n            <span class="photo-encart__badge">Zone B'
new_b = f'          <!-- \u2193 VOTRE <img> ICI \u2193 -->\n          {IMG_B}\n          <div class="photo-encart__placeholder" style="display:none;">\n            <span class="photo-encart__badge">Zone B'

old_d = '          <!-- \u2193 VOTRE <img> ICI \u2193 -->\n          <div class="photo-encart__placeholder">\n            <span class="photo-encart__badge">Zone D'
new_d = f'          <!-- \u2193 VOTRE <img> ICI \u2193 -->\n          {IMG_D}\n          <div class="photo-encart__placeholder" style="display:none;">\n            <span class="photo-encart__badge">Zone D'

c = c.replace(old_b, new_b)
c = c.replace(old_d, new_d)

print(f'B:{c.count(photo_b)} D:{c.count(photo_d)}')

with open('reduction-cycle-vente-b2b/index.html', 'w', encoding='utf-8') as f:
    f.write(c)
print('OK')
