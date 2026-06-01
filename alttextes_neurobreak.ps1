param(
    [string]$SiteRoot = "C:\Users\simon\Bureau_local\Desktop\Nouveau dossier (5)\neurobreak"
)

Write-Host "NEUROBREAK - Injection Alt Textes optimises" -ForegroundColor Cyan

if (-not (Test-Path $SiteRoot)) {
    Write-Host "ERREUR : Dossier introuvable" -ForegroundColor Red
    exit 1
}

$carteAlt = @{}

$carteAlt["automatisation-marketing-pme"] = @{
    "automatisation-marketing-pme-contexte" = "Dashboard CRM d automatisation marketing B2B pour PME - tableau de bord avec 2450 contacts, sequences de prospection actives, taux d ouverture 68% et 102 opportunites creees - systeme qui travaille en continu sans intervention manuelle"
    "automatisation-marketing-pme-territoire" = "Schema d architecture automatisation marketing B2B pour PME francophones - 3 mecaniques en cycle continu : qualification automatisee des prospects, nurturing sur 3 a 12 mois, et alertes de conversion au bon moment - CRM centralise, workflows et scoring comportemental"
}

$carteAlt["chaine-youtube-b2b-generation-leads"] = @{
    "chaine-youtube-b2b-generation-leads-contexte" = "Chaine YouTube B2B francophone avec 18 700 abonnes et contenu strategique - videos sur la generation de leads qualifies en B2B, funnel de conversion et pilotage de croissance - infrastructure d acquisition qui travaille en continu pour les PME francophones"
    "chaine-youtube-b2b-generation-leads-territoire" = "Christophe Simon NeuroBreak Studio - infographie YouTube B2B francophone quebecois : 3 a 5 ans de retard sur le marche anglophone, niches B2B sans leader YouTube, requetes strategiques en francais peu disputees - fenetre d opportunite pour la PME qui se positionne en premier"
}

$carteAlt["contenu-youtube-b2b-convertir"] = @{
    "contenu-youtube-b2b-convertir-contexte" = "Dirigeant filme en studio professionnel pour production de contenu video B2B - tournage d une video d expertise sur camera DSLR en mode enregistrement - infrastructure de contenu YouTube qui qualifie les prospects B2B avant le premier contact commercial"
    "contenu-youtube-b2b-convertir-territoire" = "Infographie 4 formats video qui convertissent en B2B quebecois - probleme nomme, mecanique exposee, objection anticipee, resultat documente - chaque format cible un stade precis du parcours decisionnel de l acheteur B2B francophone pour reduire le cycle de vente"
}

$carteAlt["crm-pme-b2b-quebec"] = @{
    "crm-pme-b2b-quebec-contexte" = "Pipeline commercial CRM pour PME B2B en vue Kanban - 18 deals actifs repartis de la prospection a la negociation, valeur totale 770 000 euros, taux de conversion 33 pourcent - outil de pilotage qui rend le cycle de vente B2B lisible et predictible pour les dirigeants de PME"
    "crm-pme-b2b-quebec-territoire" = "Dirigeant de PME B2B consultant son CRM avec pipeline de 1 210 000 dollars et alertes prioritaires - comparatif piloter a l intuition 60 pourcent de bonnes decisions vs piloter a la trajectoire 85 pourcent - le diagnostic marketing PME commence par le pipeline selon Lounas de NeuroBreak Studio"
}

$carteAlt["cycle-de-vente-b2b-accelerer"] = @{
    "cycle-de-vente-b2b-accelerer-contexte" = "Poignee de main entre deux dirigeants B2B au-dessus d un contrat signe en salle de reunion - conclusion acceleree d un deal commercial grace a un prospect arrive prepare et une decision deja amorcee avant le rendez-vous - resultat d un cycle de vente B2B bien structure"
    "cycle-de-vente-b2b-accelerer-territoire" = "Infographie 3 freins invisibles qui rallongent les cycles de vente B2B - prospect sans informations, porteur interne sans arguments pour convaincre en interne, qualification insuffisante en amont - solutions : contenu qui anticipe les questions, matrices ROI pour le porteur, qualification leads pour reduire le temps par deal conclu"
}

$carteAlt["diagnostic-marketing-pme"] = @{
    "diagnostic-marketing-pme-contexte" = "Dirigeant de PME analysant un tableau blanc de diagnostic strategique avec post-its organises par vision, strategie, offre, marketing, operations et finance - noeud central alignement et KPIs croissance CA, marge brute, NPS - cartographie des angles morts avant de prioriser les chantiers marketing B2B"
    "diagnostic-marketing-pme-territoire" = "Infographie 5 blocages qui limitent la croissance PME B2B - acquisition dependante du dirigeant, contenu qui ne convertit pas, cycle de vente trop long, CRM illisible, nurturing inexistant - solutions prioritaires : infrastructure d acquisition autonome, contenu oriente conversion, qualification amont, CRM reconfigure, nurturing B2B francophone"
}

$carteAlt["marketing-fragmente-pme"] = @{
    "marketing-fragmente-pme-contexte" = "Bureau de dirigeant de PME avec marketing fragmente visible - ecran analytique avec multiples tableaux de bord non relies, cahiers de notes epars, post-its de taches urgentes sur laptop, plusieurs outils qui ne se parlent pas - symptome classique du marketing fragmente qui epuise les equipes B2B sans produire de pipeline previsible"
    "marketing-fragmente-pme-territoire" = "Lounas NeuroBreak Studio expliquant la logique en chaine de la fragmentation marketing PME B2B - infographie cycle de vente reduit de 4 mois a 2,5 mois par qualification structuree en amont, contenu qui prepare la decision et moins d objections - citation : ce n est pas la force de vente qui est insuffisante, c est le systeme qui lui demande de faire trop"
}

$carteAlt["nurturing-b2b-francophone"] = @{
    "nurturing-b2b-francophone-contexte" = "Interface CRM avec sequence de nurturing B2B active - email de proposition de valeur en cours de redaction avec 5 etapes planifiees introduction, proposition, appel telephonique, temoignages, suivi - systeme de relance commerciale automatise qui maintient le lien avec les prospects sur 14 jours sans intervention manuelle"
    "nurturing-b2b-francophone-territoire" = "Infographie nurturing B2B en marche quebecois - 4 codes differents : sobriete de frequence un contact toutes les 2 a 4 semaines, valeur ajoutee a chaque contact, ton conversationnel plutot que corporatif, patience comme signal de confiance sur 6 a 9 mois - en B2B francophone la relation precede la transaction"
}

$carteAlt["qualification-leads-b2b"] = @{
    "qualification-leads-b2b-contexte" = "Bureau de commercial B2B avec tableau blanc entonnoir de vente 4 etapes - prospection 100 pourcent, qualification 60 pourcent, proposition 30 pourcent, closing 10 pourcent - fiches prospects classees par statut nouveaux, a contacter, en cours, chauds - systeme de qualification manuel qui montre le besoin d une structure automatisee pour les PME B2B"
    "qualification-leads-b2b-territoire" = "Infographie qualification B2B cadre BANT explique et applique - 4 criteres dans l ordre : besoin, autorite, budget, timing - questions cles pour identifier les vrais decideurs et les prospects a potentiel reel - qualifier c est gagner du temps pour le commercial et pour le prospect en marche B2B francophone"
}

$carteAlt["reduction-cycle-vente-b2b"] = @{
    "reduction-cycle-vente-b2b-contexte" = "Plan d action commercial avec calendrier et timeline de vente montrant la reduction du cycle de 90 jours a 30 jours - 5 etapes sequencees prospection jours 1-5, qualification 6-10, proposition 11-18, negociation 19-25, closing 26-30 - minuteur 30 minutes symbolisant l objectif d acceleration du cycle de vente B2B pour PME francophones"
    "reduction-cycle-vente-b2b-territoire" = "Christophe Simon NeuroBreak Studio - infographie 5 erreurs structurelles qui allongent le cycle de vente B2B : qualification trop tardive, contenu deconnecte du cycle d achat, absence de sequence decisionnelle, un seul interlocuteur prepare, rendez-vous comme premier filtre - solution : preparer la decision avant l appel car le cycle long est un probleme d architecture pas de vente"
}

$carteAlt["systeme-marketing-b2b-quebec"] = @{
    "systeme-marketing-b2b-quebec-contexte" = "Carte du reseau NeuroBreak Studio present partout au Quebec - siege social a Montreal, 6 bureaux regionaux dont Quebec, Gatineau, Sherbrooke, Saguenay, Rimouski, Rouyn-Noranda - 12 points de service et couverture provinciale complete pour les PME B2B francophones de toutes les regions du Quebec"
    "systeme-marketing-b2b-quebec-territoire" = "Christophe Simon et Olivier NeuroBreak Studio - infographie YouTube B2B francophone quebecois 3 a 5 ans de retard sur le marche anglophone - tableau comparatif marche anglophone sature vs marche quebecois sans leader YouTube B2B dans la plupart des niches - fenetre de positionnement precoce sur un terrain encore ouvert pour les PME qui structurent leur acquisition maintenant"
}

$carteAlt["systeme-marketing-centralise-pme"] = @{
    "systeme-marketing-centralise-pme-contexte" = "Dashboard marketing centralise sur grand ecran en salle de reunion - vue d ensemble avec 23 685 utilisateurs, 47 850 euros de revenus en hausse de 21 pourcent, taux de conversion 3.24 pourcent, acquisition par canal organic search 42 pourcent - systeme de pilotage marketing unifie qui rend toutes les donnees lisibles en temps reel pour les dirigeants de PME B2B"
    "systeme-marketing-centralise-pme-territoire" = "Lounas NeuroBreak Studio - infographie scenario type du systeme marketing centralise deploye : prospect regarde une video YouTube, laisse son email, sequence nurturing 3 emails sur 10 jours se declenche automatiquement, notification CRM au jour 4 prospect chaud niveau de maturite eleve, appel decisionnel - chaque etape declenche la suivante selon le comportement reel du prospect"
}

$carteAlt["drummondville-performance-b2b"] = @{
    "drummondville-contexte" = "Operateur sur ligne de production dans l entrepot Emballages Drummond a Drummondville - industrie manufacturiere d emballage du Centre-du-Quebec avec convoyeur automatise - PME B2B manufacturiere qui a besoin d un systeme marketing structure pour generer des leads qualifies"
    "drummondville-performance-b2b-territoire" = "Territoire commercial Drummondville - hub manufacturier du Centre-du-Quebec entre Montreal et Quebec, PME industrielles et d emballage qui cherchent a structurer leur marketing B2B"
}

$carteAlt["gatineau-conformite-b2b"] = @{
    "gatineau-contexte" = "Dirigeante dans un bureau gouvernemental a Gatineau avec vue sur le parlement federal d Ottawa - marche B2B de l Outaouais a l interface du secteur prive quebecois et de l administration federale canadienne - contexte unique qui exige un systeme marketing conforme et structure"
    "gatineau-conformite-b2b-territoire" = "Territoire commercial Gatineau - marche B2B de l Outaouais a proximite d Ottawa, PME quebecoises qui repondent aux appels d offres federaux et cherchent a developper leur acquisition"
}

$carteAlt["granby-systeme-b2b"] = @{
    "granby-contexte" = "Operateur en tenue de protection dans une usine agroalimentaire de transformation - industrie alimentaire et manufacturiere de la region de Granby en Monteregie - PME B2B du secteur agro-industriel qui cherche a structurer son acquisition et sa conversion commerciale"
    "granby-systeme-b2b-territoire" = "Territoire commercial Granby - ecosysteme agro-industriel de la Monteregie-Est, PME alimentaires et manufacturieres qui ont besoin d un systeme marketing B2B previsible"
}

$carteAlt["laval-export-b2b"] = @{
    "laval-contexte" = "Centre de distribution logistique Laval Logistics avec camions semi-remorques en manoeuvre - hub logistique et industriel de Laval deuxieme ville du Quebec - PME B2B du secteur transport et distribution qui a besoin d un systeme d acquisition structure pour developper ses marches"
    "laval-export-b2b-territoire" = "Territoire commercial Laval - deuxieme ville du Quebec, hub logistique et industriel de la Rive-Nord, PME B2B en expansion qui cherchent a structurer leur pipeline commercial"
}

$carteAlt["quebec-optimisation-b2b"] = @{
    "quebec-contexte" = "Reunion de direction dans une salle de conseil du gouvernement du Quebec avec drapeaux fleurdelyses - marche B2B de la capitale nationale structure autour des decisions institutionnelles et gouvernementales - PME de Quebec qui vendent aux organismes publics et prives ont besoin d un systeme marketing adapte aux cycles de decision longs"
    "quebec-optimisation-b2b-territoire" = "Territoire commercial Quebec - capitale nationale du Quebec, marche B2B a forte composante gouvernementale et institutionnelle, PME qui repondent aux appels d offres publics et prives"
}

$carteAlt["levis-pipeline-b2b"] = @{
    "levis-contexte" = "Equipe de PME Solutions Rive-Sud a Levis en reunion de planification strategique Q2 - presentation plan d action avec objectifs d optimisation des processus, lancement nouvelle offre et strategie marketing numerique - vue sur le fleuve Saint-Laurent et le pont de Quebec en arriere-plan"
    "levis-pipeline-b2b-territoire" = "Territoire commercial Levis - Rive-Sud de Quebec face a la capitale, hub industriel et de services professionnels B2B, PME en croissance qui cherchent a developper leur pipeline commercial"
}

$carteAlt["longueuil-croissance-b2b"] = @{
    "longueuil-contexte" = "Technicien specialise dans l usine Longueuil Aerospatiale assemblant un train d atterrissage d avion - secteur aerospatial haute precision de la Rive-Sud de Montreal - PME B2B de sous-traitance industrielle et aerospatiale de Longueuil qui cherchent a structurer leur acquisition commerciale pour des cycles de vente complexes"
    "longueuil-croissance-b2b-territoire" = "Territoire commercial Longueuil - pole aerospatial et industriel de la Rive-Sud de Montreal, PME de sous-traitance technique qui ont besoin d un systeme d acquisition B2B structure"
}

$carteAlt["montreal-strategie-b2b"] = @{
    "montreal-contexte" = "Equipe de PME tech a Montreal en session de planification strategique dans un espace de travail moderne - tableau blanc avec objectifs Q2 croissance, acquisition, retention, data, technologie et valeurs - PME B2B de la metropole quebecoise qui cherchent un systeme marketing structure pour accelerer leur developpement commercial"
    "montreal-strategie-b2b-territoire" = "Territoire commercial Montreal - metropole quebecoise et hub B2B francophone, ecosysteme tech, services professionnels et industrie, PME en croissance qui cherchent a structurer leur acquisition"
}

$pagesModifiees = 0
$erreurs = 0

foreach ($slug in $carteAlt.Keys) {
    $cheminPage = Join-Path $SiteRoot "$slug\index.html"
    if (-not (Test-Path $cheminPage)) {
        Write-Host "Introuvable : $slug" -ForegroundColor DarkGray
        continue
    }
    Write-Host "Traitement : $slug" -ForegroundColor Gray
    try {
        $bytes = [System.IO.File]::ReadAllBytes($cheminPage)
        $contenu = [System.Text.Encoding]::UTF8.GetString($bytes)
        $modifie = $false

        $images = $carteAlt[$slug]
        foreach ($nomImage in $images.Keys) {
            $altTexte = $images[$nomImage]
            $pattern = '(<img\s[^>]*src="/assets/' + [regex]::Escape($nomImage) + '\.[^"]*"[^>]*)alt="[^"]*"'
            if ($contenu -match $pattern) {
                $contenu = [regex]::Replace($contenu, $pattern, '$1alt="' + $altTexte + '"')
                $modifie = $true
            }
        }

        if ($modifie) {
            $outBytes = [System.Text.Encoding]::UTF8.GetBytes($contenu)
            [System.IO.File]::WriteAllBytes($cheminPage, $outBytes)
            Write-Host "  OK" -ForegroundColor Green
            $pagesModifiees++
        } else {
            Write-Host "  -- Pattern non trouve" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "  ERREUR : $($_.Exception.Message)" -ForegroundColor Red
        $erreurs++
    }
}

Write-Host ""
Write-Host "TERMINE - Pages modifiees : $pagesModifiees - Erreurs : $erreurs" -ForegroundColor Cyan
Write-Host "git add . && git commit -m 'SEO - Alt textes optimises' && git push" -ForegroundColor Yellow
