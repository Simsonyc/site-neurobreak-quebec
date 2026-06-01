param(
    [string]$SiteRoot = "C:\Users\simon\Bureau_local\Desktop\Nouveau dossier (5)\neurobreak"
)

Write-Host "NEUROBREAK - Script maillage interne" -ForegroundColor Cyan
Write-Host "Dossier : $SiteRoot" -ForegroundColor Cyan

if (-not (Test-Path $SiteRoot)) {
    Write-Host "ERREUR : Dossier introuvable : $SiteRoot" -ForegroundColor Red
    exit 1
}

$carteMaillage = @{
    "montreal-strategie-b2b"                   = @("chaine-youtube-b2b-generation-leads", "reduction-cycle-vente-b2b", "systeme-marketing-b2b-quebec")
    "quebec-optimisation-b2b"                  = @("systeme-marketing-centralise-pme", "marketing-fragmente-pme", "systeme-marketing-b2b-quebec")
    "laval-export-b2b"                         = @("chaine-youtube-b2b-generation-leads", "systeme-marketing-centralise-pme", "systeme-marketing-b2b-quebec")
    "sherbrooke-traction-b2b"                  = @("chaine-youtube-b2b-generation-leads", "reduction-cycle-vente-b2b", "systeme-marketing-b2b-quebec")
    "gatineau-conformite-b2b"                  = @("marketing-fragmente-pme", "systeme-marketing-centralise-pme", "systeme-marketing-b2b-quebec")
    "trois-rivieres-conversion-b2b"            = @("reduction-cycle-vente-b2b", "marketing-fragmente-pme", "systeme-marketing-b2b-quebec")
    "levis-pipeline-b2b"                       = @("reduction-cycle-vente-b2b", "systeme-marketing-centralise-pme", "systeme-marketing-b2b-quebec")
    "drummondville-performance-b2b"            = @("systeme-marketing-centralise-pme", "marketing-fragmente-pme", "systeme-marketing-b2b-quebec")
    "rimouski-strategie-b2b"                   = @("chaine-youtube-b2b-generation-leads", "marketing-fragmente-pme", "systeme-marketing-b2b-quebec")
    "saint-jean-sur-richelieu-acquisition-b2b" = @("chaine-youtube-b2b-generation-leads", "reduction-cycle-vente-b2b", "systeme-marketing-b2b-quebec")
    "shawinigan-orchestration-b2b"             = @("systeme-marketing-centralise-pme", "marketing-fragmente-pme", "systeme-marketing-b2b-quebec")
    "granby-systeme-b2b"                       = @("systeme-marketing-centralise-pme", "reduction-cycle-vente-b2b", "systeme-marketing-b2b-quebec")
    "victoriaville-orchestration-b2b"          = @("systeme-marketing-centralise-pme", "marketing-fragmente-pme", "systeme-marketing-b2b-quebec")
    "brossard-developpement-b2b"               = @("chaine-youtube-b2b-generation-leads", "reduction-cycle-vente-b2b", "systeme-marketing-b2b-quebec")
    "terrebonne-acquisition-b2b"               = @("chaine-youtube-b2b-generation-leads", "marketing-fragmente-pme", "systeme-marketing-b2b-quebec")
    "repentigny-acquisition-b2b"               = @("chaine-youtube-b2b-generation-leads", "systeme-marketing-centralise-pme", "systeme-marketing-b2b-quebec")
    "blainville-acquisition-b2b"               = @("chaine-youtube-b2b-generation-leads", "reduction-cycle-vente-b2b", "systeme-marketing-b2b-quebec")
    "saguenay-acquisition-b2b"                 = @("marketing-fragmente-pme", "systeme-marketing-centralise-pme", "systeme-marketing-b2b-quebec")
    "saint-hyacinthe-marketing-b2b"            = @("systeme-marketing-centralise-pme", "reduction-cycle-vente-b2b", "systeme-marketing-b2b-quebec")
    "longueuil-croissance-b2b"                 = @("chaine-youtube-b2b-generation-leads", "marketing-fragmente-pme", "systeme-marketing-b2b-quebec")
    "blainville-orchestration-b2b"             = @("systeme-marketing-centralise-pme", "marketing-fragmente-pme", "systeme-marketing-b2b-quebec")
    "repentigny-cycle-vente-b2b"               = @("reduction-cycle-vente-b2b", "marketing-fragmente-pme", "systeme-marketing-b2b-quebec")
    "terrebonne-expansion-b2b"                 = @("systeme-marketing-centralise-pme", "chaine-youtube-b2b-generation-leads", "systeme-marketing-b2b-quebec")
    "saint-jerome-acceleration-b2b"            = @("chaine-youtube-b2b-generation-leads", "reduction-cycle-vente-b2b", "systeme-marketing-b2b-quebec")
    "rouyn-noranda-b2b"                        = @("marketing-fragmente-pme", "systeme-marketing-centralise-pme", "systeme-marketing-b2b-quebec")
    "sept-iles-b2b"                            = @("marketing-fragmente-pme", "chaine-youtube-b2b-generation-leads", "systeme-marketing-b2b-quebec")
}

$labelsPiliers = @{
    "chaine-youtube-b2b-generation-leads" = "Acquisition YouTube B2B pour PME"
    "reduction-cycle-vente-b2b"           = "Reduire le cycle de vente B2B"
    "systeme-marketing-centralise-pme"    = "Systeme marketing centralise PME"
    "marketing-fragmente-pme"             = "Marketing fragmente PME"
    "systeme-marketing-b2b-quebec"        = "Systeme marketing B2B au Quebec"
}

$pagesModifiees = 0
$erreurs = 0

foreach ($slug in $carteMaillage.Keys) {
    $cheminPage = Join-Path $SiteRoot "$slug\index.html"

    if (-not (Test-Path $cheminPage)) {
        Write-Host "Introuvable : $slug" -ForegroundColor DarkGray
        continue
    }

    Write-Host "Traitement : $slug" -ForegroundColor Gray

    try {
        $bytes = [System.IO.File]::ReadAllBytes($cheminPage)
        $contenu = [System.Text.Encoding]::UTF8.GetString($bytes)

        if ($contenu -match 'maillage-interne') {
            Write-Host "  -- Deja a jour" -ForegroundColor DarkGray
            continue
        }

        # Construire les lignes de liens
        $piliers = $carteMaillage[$slug]
        $lignes = ""
        foreach ($pilier in $piliers) {
            $label = $labelsPiliers[$pilier]
            if ($label) {
                $ligne = '<li style="display:flex;padding:.6rem 0;border-bottom:1px solid var(--ligne-2);font-family:var(--f-sans);font-size:.88rem;font-weight:300;color:var(--txt-3);">'
                $ligne += '<a href="/' + $pilier + '" style="color:var(--vif);text-decoration:none;font-family:var(--f-sans);font-size:.88rem;">&#8594; ' + $label + '</a>'
                $ligne += '</li>'
                $lignes += $ligne + "`n"
            }
        }

        # Construire la section complete
        $section  = '<section class="maillage-interne" style="border-top:1px solid var(--ligne);padding:3rem 2.5rem;max-width:var(--max);margin:0 auto;">' + "`n"
        $section += '<div style="display:grid;grid-template-columns:120px 1fr;gap:0 3rem;">' + "`n"
        $section += '<div><span style="font-family:var(--f-mono);font-size:.6rem;color:var(--txt-4);letter-spacing:.14em;text-transform:uppercase;">Aller plus loin</span></div>' + "`n"
        $section += '<div>' + "`n"
        $section += '<p style="font-family:var(--f-serif);font-size:1.05rem;font-weight:700;color:var(--txt);margin-bottom:1rem;">Approfondir l architecture B2B</p>' + "`n"
        $section += '<ul style="list-style:none;border-top:1px solid var(--ligne-2);">' + "`n"
        $section += $lignes
        $section += '</ul>' + "`n"
        $section += '</div>' + "`n"
        $section += '</div>' + "`n"
        $section += '</section>' + "`n"

        # Injecter avant </main>
        if ($contenu -match '</main>') {
            $contenu = [regex]::Replace($contenu, '</main>', $section + '</main>', 1)
            $outBytes = [System.Text.Encoding]::UTF8.GetBytes($contenu)
            [System.IO.File]::WriteAllBytes($cheminPage, $outBytes)
            Write-Host "  OK - $($piliers.Count) liens injectes" -ForegroundColor Green
            $pagesModifiees++
        } else {
            Write-Host "  -- </main> introuvable" -ForegroundColor Yellow
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
Write-Host "git commit -m 'Maillage interne - section Aller plus loin sur toutes les pages villes'" -ForegroundColor White
Write-Host "git push" -ForegroundColor White
