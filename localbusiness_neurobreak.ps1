param(
    [string]$SiteRoot = "C:\Users\simon\Bureau_local\Desktop\Nouveau dossier (5)\neurobreak"
)

Write-Host "NEUROBREAK - Script JSON-LD LocalBusiness" -ForegroundColor Cyan
Write-Host "Dossier : $SiteRoot" -ForegroundColor Cyan

if (-not (Test-Path $SiteRoot)) {
    Write-Host "ERREUR : Dossier introuvable : $SiteRoot" -ForegroundColor Red
    exit 1
}

# Carte des pages villes avec donnees LocalBusiness
$carteVilles = @{
    "montreal-strategie-b2b" = @{
        ville = "Montreal"; region = "QC"; slug = "montreal-strategie-b2b"
        desc = "Architecture marketing B2B pour PME de Montreal. Acquisition, conversion et orchestration pour les entreprises B2B de l'ile de Montreal."
    }
    "quebec-optimisation-b2b" = @{
        ville = "Quebec"; region = "QC"; slug = "quebec-optimisation-b2b"
        desc = "Systeme marketing B2B pour PME de Quebec. NeuroBreak structure l'acquisition et la conversion pour les entreprises B2B de la region de Quebec."
    }
    "laval-export-b2b" = @{
        ville = "Laval"; region = "QC"; slug = "laval-export-b2b"
        desc = "Architecture marketing B2B pour PME de Laval. Systeme d'acquisition et de conversion pour les entreprises B2B lavelloises."
    }
    "sherbrooke-traction-b2b" = @{
        ville = "Sherbrooke"; region = "QC"; slug = "sherbrooke-traction-b2b"
        desc = "Systeme marketing B2B pour PME tech de Sherbrooke. Acquisition YouTube et conversion pour les entreprises B2B de l'Estrie."
    }
    "gatineau-conformite-b2b" = @{
        ville = "Gatineau"; region = "QC"; slug = "gatineau-conformite-b2b"
        desc = "Architecture marketing B2B pour PME de Gatineau. Systeme de generation de leads pour les entreprises B2B de l'Outaouais."
    }
    "trois-rivieres-conversion-b2b" = @{
        ville = "Trois-Rivieres"; region = "QC"; slug = "trois-rivieres-conversion-b2b"
        desc = "Systeme marketing B2B pour PME de Trois-Rivieres. Conversion et orchestration pour les entreprises B2B de la Mauricie."
    }
    "levis-pipeline-b2b" = @{
        ville = "Levis"; region = "QC"; slug = "levis-pipeline-b2b"
        desc = "Architecture marketing B2B pour PME de Levis. Pipeline commercial et conversion pour les entreprises B2B de la Rive-Sud de Quebec."
    }
    "drummondville-performance-b2b" = @{
        ville = "Drummondville"; region = "QC"; slug = "drummondville-performance-b2b"
        desc = "Systeme marketing B2B pour PME de Drummondville. Performance commerciale et orchestration pour les entreprises B2B du Centre-du-Quebec."
    }
    "rimouski-strategie-b2b" = @{
        ville = "Rimouski"; region = "QC"; slug = "rimouski-strategie-b2b"
        desc = "Architecture marketing B2B pour PME de Rimouski. Strategie d'acquisition et de conversion pour les entreprises B2B du Bas-Saint-Laurent."
    }
    "saint-jean-sur-richelieu-acquisition-b2b" = @{
        ville = "Saint-Jean-sur-Richelieu"; region = "QC"; slug = "saint-jean-sur-richelieu-acquisition-b2b"
        desc = "Systeme marketing B2B pour PME de Saint-Jean-sur-Richelieu. Acquisition et conversion pour les entreprises B2B de la Monteregie."
    }
    "shawinigan-orchestration-b2b" = @{
        ville = "Shawinigan"; region = "QC"; slug = "shawinigan-orchestration-b2b"
        desc = "Architecture marketing B2B pour PME de Shawinigan. Orchestration et systeme centralise pour les entreprises B2B de la Mauricie."
    }
    "granby-systeme-b2b" = @{
        ville = "Granby"; region = "QC"; slug = "granby-systeme-b2b"
        desc = "Systeme marketing B2B pour PME de Granby. Architecture commerciale pour les entreprises B2B de la region de Granby."
    }
    "victoriaville-orchestration-b2b" = @{
        ville = "Victoriaville"; region = "QC"; slug = "victoriaville-orchestration-b2b"
        desc = "Architecture marketing B2B pour PME de Victoriaville. Orchestration et pilotage pour les entreprises manufacturieres du Centre-du-Quebec."
    }
    "brossard-developpement-b2b" = @{
        ville = "Brossard"; region = "QC"; slug = "brossard-developpement-b2b"
        desc = "Systeme marketing B2B pour PME de Brossard. Developpement commercial et acquisition pour les entreprises B2B de la Rive-Sud de Montreal."
    }
    "terrebonne-acquisition-b2b" = @{
        ville = "Terrebonne"; region = "QC"; slug = "terrebonne-acquisition-b2b"
        desc = "Architecture marketing B2B pour PME de Terrebonne. Acquisition et pipeline commercial pour les entreprises B2B des Laurentides."
    }
    "repentigny-acquisition-b2b" = @{
        ville = "Repentigny"; region = "QC"; slug = "repentigny-acquisition-b2b"
        desc = "Systeme marketing B2B pour PME de Repentigny. Acquisition et conversion pour les entreprises B2B de Lanaudiere."
    }
    "blainville-acquisition-b2b" = @{
        ville = "Blainville"; region = "QC"; slug = "blainville-acquisition-b2b"
        desc = "Architecture marketing B2B pour PME de Blainville. Acquisition et orchestration pour les entreprises B2B des Laurentides."
    }
    "saguenay-acquisition-b2b" = @{
        ville = "Saguenay"; region = "QC"; slug = "saguenay-acquisition-b2b"
        desc = "Systeme marketing B2B pour PME de Saguenay. Acquisition et developpement commercial pour les entreprises B2B du Saguenay-Lac-Saint-Jean."
    }
    "saint-hyacinthe-marketing-b2b" = @{
        ville = "Saint-Hyacinthe"; region = "QC"; slug = "saint-hyacinthe-marketing-b2b"
        desc = "Architecture marketing B2B pour PME de Saint-Hyacinthe. Systeme commercial pour les entreprises B2B agroalimentaires de la Monteregie."
    }
    "longueuil-croissance-b2b" = @{
        ville = "Longueuil"; region = "QC"; slug = "longueuil-croissance-b2b"
        desc = "Systeme marketing B2B pour PME de Longueuil. Croissance commerciale et acquisition pour les entreprises B2B de la Rive-Sud."
    }
    "blainville-orchestration-b2b" = @{
        ville = "Blainville"; region = "QC"; slug = "blainville-orchestration-b2b"
        desc = "Orchestration marketing B2B pour PME de Blainville. Systeme centralise pour les entreprises B2B des Laurentides."
    }
    "repentigny-cycle-vente-b2b" = @{
        ville = "Repentigny"; region = "QC"; slug = "repentigny-cycle-vente-b2b"
        desc = "Reduction du cycle de vente B2B pour PME de Repentigny. Conversion acceleree pour les entreprises B2B de Lanaudiere."
    }
    "terrebonne-expansion-b2b" = @{
        ville = "Terrebonne"; region = "QC"; slug = "terrebonne-expansion-b2b"
        desc = "Expansion commerciale B2B pour PME de Terrebonne. Systeme de croissance pour les entreprises B2B des Laurentides."
    }
    "saint-jerome-acceleration-b2b" = @{
        ville = "Saint-Jerome"; region = "QC"; slug = "saint-jerome-acceleration-b2b"
        desc = "Acceleration commerciale B2B pour PME de Saint-Jerome. Acquisition et conversion pour les entreprises B2B des Laurentides."
    }
    "rouyn-noranda-b2b" = @{
        ville = "Rouyn-Noranda"; region = "QC"; slug = "rouyn-noranda-b2b"
        desc = "Systeme marketing B2B pour PME de Rouyn-Noranda. Architecture commerciale pour les entreprises B2B de l'Abitibi-Temiscamingue."
    }
    "sept-iles-b2b" = @{
        ville = "Sept-Iles"; region = "QC"; slug = "sept-iles-b2b"
        desc = "Architecture marketing B2B pour PME de Sept-Iles. Systeme d'acquisition pour les entreprises B2B de la Cote-Nord."
    }
}

$pagesModifiees = 0
$erreurs = 0

foreach ($slug in $carteVilles.Keys) {
    $cheminPage = Join-Path $SiteRoot "$slug\index.html"

    if (-not (Test-Path $cheminPage)) {
        Write-Host "Introuvable : $slug" -ForegroundColor DarkGray
        continue
    }

    Write-Host "Traitement : $slug" -ForegroundColor Gray

    try {
        $bytes = [System.IO.File]::ReadAllBytes($cheminPage)
        $contenu = [System.Text.Encoding]::UTF8.GetString($bytes)

        # Verifier si LocalBusiness existe deja
        if ($contenu -match '"@type":"LocalBusiness"') {
            Write-Host "  -- Deja a jour" -ForegroundColor DarkGray
            continue
        }

        $data = $carteVilles[$slug]
        $ville = $data.ville
        $region = $data.region
        $slugPage = $data.slug
        $desc = $data.desc

        # Construire le JSON-LD LocalBusiness
        $jsonLD  = '<script type="application/ld+json">'
        $jsonLD += '{"@context":"https://schema.org",'
        $jsonLD += '"@type":"LocalBusiness",'
        $jsonLD += '"name":"NeuroBreak Studio - ' + $ville + '",'
        $jsonLD += '"description":"' + $desc + '",'
        $jsonLD += '"url":"https://neurobreak.eu/' + $slugPage + '",'
        $jsonLD += '"image":"https://neurobreak.eu/assets/' + $slugPage + '-contexte.png",'
        $jsonLD += '"priceRange":"$$",'
        $jsonLD += '"areaServed":{"@type":"City","name":"' + $ville + '","addressRegion":"' + $region + '","addressCountry":"CA"},'
        $jsonLD += '"address":{"@type":"PostalAddress","addressLocality":"' + $ville + '","addressRegion":"' + $region + '","addressCountry":"CA"},'
        $jsonLD += '"founder":{"@type":"Person","name":"Christophe Simon"},'
        $jsonLD += '"parentOrganization":{"@type":"Organization","name":"NeuroBreak Studio","url":"https://neurobreak.eu"}}'
        $jsonLD += '</script>'

        # Injecter apres le dernier script ld+json existant
        $pattern = '((?s).*<script type="application/ld\+json">.*?</script>)'
        if ($contenu -match '(<script type="application/ld\+json">(?:(?!</script>).)*</script>)(?![\s\S]*<script type="application/ld\+json">)') {
            $contenu = [regex]::Replace(
                $contenu,
                '(<script type="application/ld\+json">(?:(?!</script>).)*</script>)(?![\s\S]*<script type="application/ld\+json">)',
                '$1' + "`n" + $jsonLD,
                [System.Text.RegularExpressions.RegexOptions]::Singleline
            )
            $outBytes = [System.Text.Encoding]::UTF8.GetBytes($contenu)
            [System.IO.File]::WriteAllBytes($cheminPage, $outBytes)
            Write-Host "  OK - LocalBusiness injecte pour $ville" -ForegroundColor Green
            $pagesModifiees++
        } else {
            # Fallback : injecter avant </head>
            $contenu = $contenu -replace '</head>', ($jsonLD + "`n</head>")
            $outBytes = [System.Text.Encoding]::UTF8.GetBytes($contenu)
            [System.IO.File]::WriteAllBytes($cheminPage, $outBytes)
            Write-Host "  OK - LocalBusiness injecte (fallback) pour $ville" -ForegroundColor Green
            $pagesModifiees++
        }

    } catch {
        Write-Host "  ERREUR : $($_.Exception.Message)" -ForegroundColor Red
        $erreurs++
    }
}

Write-Host ""
Write-Host "TERMINE" -ForegroundColor Cyan
Write-Host "Pages modifiees : $pagesModifiees" -ForegroundColor Green
Write-Host "Erreurs         : $erreurs" -ForegroundColor $(if ($erreurs -gt 0) { "Red" } else { "Green" })
Write-Host ""
Write-Host "PROCHAINE ETAPE :" -ForegroundColor Yellow
Write-Host "git add ." -ForegroundColor White
Write-Host "git commit -m 'SEO local - JSON-LD LocalBusiness sur toutes les pages villes'" -ForegroundColor White
Write-Host "git push" -ForegroundColor White
