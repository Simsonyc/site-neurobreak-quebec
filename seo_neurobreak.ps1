param(
    [string]$SiteRoot = "C:\Users\simon\Bureau_local\Desktop\Nouveau dossier (5)\neurobreak"
)

Write-Host "NEUROBREAK - Script SEO automatique" -ForegroundColor Cyan
Write-Host "Dossier : $SiteRoot" -ForegroundColor Cyan

if (-not (Test-Path $SiteRoot)) {
    Write-Host "ERREUR : Dossier introuvable : $SiteRoot" -ForegroundColor Red
    exit 1
}

$pagesModifiees = 0
$erreurs = 0

$nouveauFooter = '<footer class="footer"><div class="footer__inner"><a class="footer__logo" href="/">NEURO<i>BREAK</i>&#8482;</a><ul aria-label="Services" class="footer__nav"><li><a href="/marketing-fragmente-pme">Marketing fragmente</a></li><li><a href="/chaine-youtube-b2b-generation-leads">YouTube B2B</a></li><li><a href="/reduction-cycle-vente-b2b">Cycle de vente</a></li><li><a href="/systeme-marketing-centralise-pme">Orchestration</a></li><li><a href="/systeme-marketing-b2b-quebec">Hub Quebec</a></li><li><a href="/francophonie-systeme-marketing-b2b">Hub Francophonie</a></li></ul><ul aria-label="Territoires Quebec" class="footer__nav"><li><a href="/montreal-strategie-b2b">Montreal</a></li><li><a href="/quebec-optimisation-b2b">Quebec</a></li><li><a href="/laval-export-b2b">Laval</a></li><li><a href="/sherbrooke-traction-b2b">Sherbrooke</a></li><li><a href="/gatineau-conformite-b2b">Gatineau</a></li><li><a href="/trois-rivieres-conversion-b2b">Trois-Rivieres</a></li><li><a href="/levis-pipeline-b2b">Levis</a></li><li><a href="/drummondville-performance-b2b">Drummondville</a></li><li><a href="/rimouski-strategie-b2b">Rimouski</a></li><li><a href="/saint-jean-sur-richelieu-acquisition-b2b">Saint-Jean-sur-Richelieu</a></li></ul><ul aria-label="Territoires Couronne" class="footer__nav"><li><a href="/shawinigan-orchestration-b2b">Shawinigan</a></li><li><a href="/granby-systeme-b2b">Granby</a></li><li><a href="/victoriaville-orchestration-b2b">Victoriaville</a></li><li><a href="/brossard-developpement-b2b">Brossard</a></li><li><a href="/terrebonne-acquisition-b2b">Terrebonne</a></li><li><a href="/repentigny-acquisition-b2b">Repentigny</a></li><li><a href="/blainville-acquisition-b2b">Blainville</a></li><li><a href="/saguenay-acquisition-b2b">Saguenay</a></li><li><a href="/saint-hyacinthe-marketing-b2b">Saint-Hyacinthe</a></li><li><a href="/longueuil-croissance-b2b">Longueuil</a></li></ul><p class="footer__copy">&#169; 2026 NeuroBreak&#8482; Studio &#8212; Christophe Simon. Tous droits reserves.</p><p class="footer__copy" style="margin-top:.35rem;"><a href="/mentions-legales" style="color:rgba(248,246,241,.35);text-decoration:none;letter-spacing:.06em;font-family:var(--f-mono);font-size:.6rem;">Mentions legales</a><span style="color:rgba(248,246,241,.15);margin:0 .75rem;">&#183;</span><a href="/politique-confidentialite" style="color:rgba(248,246,241,.35);text-decoration:none;letter-spacing:.06em;font-family:var(--f-mono);font-size:.6rem;">Politique de confidentialite</a><span style="color:rgba(248,246,241,.15);margin:0 .75rem;">&#183;</span><a href="/rgpd" style="color:rgba(248,246,241,.35);text-decoration:none;letter-spacing:.06em;font-family:var(--f-mono);font-size:.6rem;">RGPD</a></p></div></footer>'

$jsonOrg = '<script type="application/ld+json">{"@context":"https://schema.org","@type":"Organization","name":"NeuroBreak Studio","url":"https://neurobreak.eu","description":"Architecture marketing B2B pour PME francophones au Quebec","founder":{"@type":"Person","name":"Christophe Simon"},"areaServed":{"@type":"Country","name":"Canada"},"sameAs":["https://neurobreak.ca"]}</script>'

$fichiers = Get-ChildItem -Path $SiteRoot -Recurse -Filter "index.html"
Write-Host "$($fichiers.Count) fichiers index.html trouves." -ForegroundColor Yellow

foreach ($fichier in $fichiers) {
    Write-Host "Traitement : $($fichier.FullName)" -ForegroundColor Gray
    try {
        $bytes = [System.IO.File]::ReadAllBytes($fichier.FullName)
        $contenu = [System.Text.Encoding]::UTF8.GetString($bytes)
        $modifie = $false

        # 1. Remplacer le footer
        $ancienFooterPattern = '(?s)<footer class="footer">.*?</footer>'
        if ($contenu -match $ancienFooterPattern) {
            $contenu = [regex]::Replace($contenu, $ancienFooterPattern, $nouveauFooter)
            $modifie = $true
        }

        # 2. Corriger copyright
        if ($contenu -match '2025 NeuroBreak') {
            $contenu = $contenu -replace '2025 NeuroBreak', '2026 NeuroBreak'
            $modifie = $true
        }

        # 3. Ajouter JSON-LD Organization si absent
        if ($contenu -notmatch '"@type":"Organization"') {
            $contenu = $contenu -replace '(<link href="https://fonts\.googleapis\.com" rel="preconnect"/>)', ($jsonOrg + "`n" + '$1')
            $modifie = $true
        }

        # 4. Ajouter Open Graph si absent
        if ($contenu -notmatch 'og:title') {
            $titleMatch = [regex]::Match($contenu, '<title>(.*?)</title>')
            $descMatch = [regex]::Match($contenu, 'name="description" content="(.*?)"')
            $canonicalMatch = [regex]::Match($contenu, 'href="(https://neurobreak\.eu[^"]*)" rel="canonical"')

            $ogTitle = if ($titleMatch.Success) { $titleMatch.Groups[1].Value } else { "NeuroBreak Studio" }
            $ogDesc = if ($descMatch.Success) { $descMatch.Groups[1].Value } else { "Architecture marketing B2B pour PME francophones." }
            $ogUrl = if ($canonicalMatch.Success) { $canonicalMatch.Groups[1].Value } else { "https://neurobreak.eu" }

            $slugMatch = [regex]::Match($ogUrl, 'neurobreak\.eu/(.+)$')
            $slug = if ($slugMatch.Success) { $slugMatch.Groups[1].Value } else { "neurobreak" }
            $ogImage = "https://neurobreak.eu/assets/" + $slug + "-contexte.png"

            $ogTags = "<meta property=`"og:type`" content=`"article`"/>`n<meta property=`"og:title`" content=`"" + $ogTitle + "`"/>`n<meta property=`"og:description`" content=`"" + $ogDesc + "`"/>`n<meta property=`"og:url`" content=`"" + $ogUrl + "`"/>`n<meta property=`"og:image`" content=`"" + $ogImage + "`"/>`n<meta property=`"og:locale`" content=`"fr_CA`"/>`n<meta property=`"og:site_name`" content=`"NeuroBreak Studio`"/>`n<meta name=`"twitter:card`" content=`"summary_large_image`"/>`n<meta name=`"twitter:title`" content=`"" + $ogTitle + "`"/>`n<meta name=`"twitter:description`" content=`"" + $ogDesc + "`"/>`n<meta name=`"twitter:image`" content=`"" + $ogImage + "`"/>"

            $contenu = $contenu -replace '(<link href="https://neurobreak\.eu[^"]*" rel="canonical"/>)', ('$1' + "`n" + $ogTags)
            $modifie = $true
        }

        # 5. Lazy loading sur les images non hero
        if ($contenu -notmatch 'loading="lazy"') {
            $contenu = [regex]::Replace($contenu, '(<img src="/assets/(?!christophe)[^"]*")', '$1 loading="lazy"')
            $modifie = $true
        }

        # 6. Ameliorer les alt textes
        if ($contenu -match 'alt="Olivier"') {
            $contenu = $contenu -replace 'alt="Olivier"', 'alt="Olivier - responsable deploiement NeuroBreak, automatisation marketing B2B"'
            $modifie = $true
        }
        if ($contenu -match 'alt="Lounas"') {
            $contenu = $contenu -replace 'alt="Lounas"', 'alt="Lounas - croissance commerciale NeuroBreak, 25 ans de management commercial"'
            $modifie = $true
        }

        if ($modifie) {
            $outBytes = [System.Text.Encoding]::UTF8.GetBytes($contenu)
            [System.IO.File]::WriteAllBytes($fichier.FullName, $outBytes)
            Write-Host "  OK - Modifie" -ForegroundColor Green
            $pagesModifiees++
        } else {
            Write-Host "  -- Deja a jour" -ForegroundColor DarkGray
        }

    } catch {
        Write-Host "  ERREUR : $($_.Exception.Message)" -ForegroundColor Red
        $erreurs++
    }
}

# Creer sitemap.xml
Write-Host "Creation du sitemap.xml..." -ForegroundColor Yellow
$sitemap = '<?xml version="1.0" encoding="UTF-8"?><urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"><url><loc>https://neurobreak.eu/</loc><lastmod>2026-01-01</lastmod><changefreq>monthly</changefreq><priority>1.0</priority></url><url><loc>https://neurobreak.eu/systeme-marketing-b2b-quebec</loc><lastmod>2026-01-01</lastmod><changefreq>monthly</changefreq><priority>0.9</priority></url><url><loc>https://neurobreak.eu/francophonie-systeme-marketing-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.9</priority></url><url><loc>https://neurobreak.eu/marketing-fragmente-pme</loc><lastmod>2026-01-01</lastmod><priority>0.8</priority></url><url><loc>https://neurobreak.eu/chaine-youtube-b2b-generation-leads</loc><lastmod>2026-01-01</lastmod><priority>0.8</priority></url><url><loc>https://neurobreak.eu/reduction-cycle-vente-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.8</priority></url><url><loc>https://neurobreak.eu/systeme-marketing-centralise-pme</loc><lastmod>2026-01-01</lastmod><priority>0.8</priority></url><url><loc>https://neurobreak.eu/automatisation-marketing-pme</loc><lastmod>2026-01-01</lastmod><priority>0.8</priority></url><url><loc>https://neurobreak.eu/montreal-strategie-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/quebec-optimisation-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/laval-export-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/sherbrooke-traction-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/gatineau-conformite-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/trois-rivieres-conversion-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/levis-pipeline-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/drummondville-performance-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/rimouski-strategie-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/saint-jean-sur-richelieu-acquisition-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/shawinigan-orchestration-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/granby-systeme-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/victoriaville-orchestration-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/brossard-developpement-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/terrebonne-acquisition-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/repentigny-acquisition-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/blainville-acquisition-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/saguenay-acquisition-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/saint-hyacinthe-marketing-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/longueuil-croissance-b2b</loc><lastmod>2026-01-01</lastmod><priority>0.7</priority></url><url><loc>https://neurobreak.eu/mentions-legales</loc><priority>0.3</priority></url><url><loc>https://neurobreak.eu/politique-confidentialite</loc><priority>0.3</priority></url><url><loc>https://neurobreak.eu/rgpd</loc><priority>0.3</priority></url></urlset>'

$sitemapPath = Join-Path $SiteRoot "sitemap.xml"
[System.IO.File]::WriteAllText($sitemapPath, $sitemap, [System.Text.Encoding]::UTF8)
Write-Host "  OK - sitemap.xml cree" -ForegroundColor Green

$robots = "User-agent: *`nAllow: /`nDisallow: /api/`n`nSitemap: https://neurobreak.eu/sitemap.xml"
$robotsPath = Join-Path $SiteRoot "robots.txt"
[System.IO.File]::WriteAllText($robotsPath, $robots, [System.Text.Encoding]::UTF8)
Write-Host "  OK - robots.txt cree" -ForegroundColor Green

Write-Host ""
Write-Host "TERMINE" -ForegroundColor Cyan
Write-Host "Pages modifiees : $pagesModifiees" -ForegroundColor Green
Write-Host "Erreurs         : $erreurs" -ForegroundColor $(if ($erreurs -gt 0) { "Red" } else { "Green" })
Write-Host ""
Write-Host "PROCHAINE ETAPE : Soumettre le sitemap dans Google Search Console" -ForegroundColor Yellow
Write-Host "https://search.google.com/search-console" -ForegroundColor Yellow
