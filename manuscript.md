---
documentclass: report
classoption: oneside
date: false
polyglossia-lang:
  name: french
geometry:
  - left = 2cm
  - right = 2cm
  - top = 2cm
  - bottom = 2cm
fontsize: 12pt
toc: true
linestretch: false
bibliography: [./ref_interaction_inference.bib] # This field is overid when pandoc is use, but it allow to use citation completion when writting.
# The model
#
#This is a citation: @Martinez2002 -- we can also have citations in brackets
#[@Martinez2002].
#
# Lists
#
#1. one fish
#2. two fish
#3. red fish
#4. blue fish
#
# Methods
#
#There is an equation, which we can cite with {@eq:eq1}.
#
#$$J'(p) = \frac{1}{\text{log}(S)}\times\left(-\sum p \text{log}(p)\right)$$ {#eq:eq1}
#
# Tables
#
#We can do tables:
#
#| Column 1 | Column 2 |      Column 3    |
#| -------- | :-------:| ---------------: |
#| c1       |    c2    |       $\alpha$   |
#
#Table: Demonstration of a simple table. {#tbl:1}
#
#The first column is neat, the second centered and the third right-aligned. We can also cite table with {@tbl:1}
#
# Figures
#
#![This is the legend of the figure](figures/biomes.png){#fig:biomes}
#
#We can refer to @fig:biomes.
#
# Code?
#
#Yes
#
#~~~ julia
#for i in eachindex(x)
#  x[i] = zero(eltype(x)) # Don't do that
#end
#~~~
#
# References
---

# Introduction

# Matériel et méthode

## Jeu de données

Le jeu de donnée utilisé dans ce travail est issu du *REseau de surveillance BENthique*. Ce réseau de surveillance a été créé en 1999 à la suite du naufrage du pétrolier Erika. Le but de ce réseau est d'acquérir des connaissances sur les habitats benthiques côtiers et de détecter des changements de la diversité biologique de ces habitats [@Rebent2016]. Ce sont six habitats benthiques différents  répartis sur l'ensemble des côtes bretonnes que surveille le *REBENT*.  Seulement deux de ces habitats ont été retenus pour comparer les trois méthodes de modélisations : les herbiers de zostères et les sédiments meubles nus.

### Habitats

Les zostères sont des phanérogames marines qui lorsque leur densité est forte, créent des "herbiers". En Bretagne, il existe deux espèces de zostères : la zostère marine (*Zostera marina*) et la zostère naine (*Zostera noltii*). Ces herbiers forment des habitats pour de nombreuses espèces. Ils ont un rôle fonctionnel important pour beaucoup d'espèces en tant que zone de nurserie, de reproduction et de nourrissage. Le suivi du *REBENT* se concentre sur les herbiers de *Z. marina*, car cette espèce fait déjà partie du livre rouge des espèces menacées [@Rebent2016].

L'estran aux sédiments meuble se compose majoritairement de deux types de sédiments : des sédiments fins et des sédiments hétérogènes envasés. Les biocénoses à sables fins sont soumises à de fortes contraintes hydrodynamiques capables de brasser le sédiment en profondeur pouvant entrainer des modifications importantes des peuplements faunistiques. Les plages de sable fin servent d'habitats pour certaines espèces de bivalves, ou bien encore de zones de nurserie pour les poissons plats. Les biocénoses à sédiment hétérogène envasé se retrouvent principalement dans les baies et criques abritées de la houle. Cet habitat abrite des espèces de bivalves à fort intérêt social économique, car apprécié par les pécheurs à pied [@Rebent2016].

Vingt-trois sites le long de la façade bretonne ont été retenus. Certains présentent à la fois ces deux habitats. Vingt sites ont été utilisés pour entrainer les différents modèles et trois ont été utilisés pour faire de la validation croisée sur ces mêmes modèles (fig. @fig:sitemap).

![Carte des sites échantillonnés. Les points bleus et verts représentent respectivement les sites à sédiments meubles et les herbiers. Les points rouges représentent les sites ayant les deux habitats. 1. Sites utilisés pour entrainer les modèles. 2. Sites utilisés pour valider les modèles](figures/site_map.png){#fig:sitemap}

### Communauté faunistique

La communauté faunistique d’intérêt dans ce travail est celle des polychètes. Les polychètes sont des animaux marins du phylum des annélides. Cette classe a été choisie, car les animaux la composant ont des modes de vie très divers. Il est classique de catégoriser les polychètes en plusieurs groupes en fonction de leur habitat : certains sont nageurs, ou tubicoles, ou bien encore benthiques fouisseurs. Leurs régimes alimentaires sont aussi très variés, il existe des polychètes prédateurs, mais également des suspensivores ou psamivores [@Lecointre_2001].

### Données environnementales 

Les données environnementales proviennent du programme [NDR : demander à Aurélien]. Six variables environnementales ont été selectionné d'après les travaux de [NDR: mettre la thèse d'Aurelien] (tableau : {@tbl:1}). Chaque variable environnementale a été centrée et transformée en polynôme de degrés un avant d'être utilisé par les différents modèles. 

|  Abréviation  |     Définition     |    Unité        |
| :-----------: | :----------------  | :-------------- |
|   Average     |    Fetch moyen     |     Aurélien   
|   MO          |   Concentration en Matière organique  |   %   |
|   SAL_sd_w    | Ecart-type de la salinité de l'eau | Aurélien |
|   TEMP_sd_w   | Ecart-type de la température de l'eau | °C |
|   CURR_mean_w | Force moyenne des courants | Knts? |
|   mud         | Concentration de boue dans les sédiments | Aurélien |
|   Trask_So    | Indice de Trask    | Aucune
Table: Variables environnementales utilisées par tous les modèles. {#tbl:1}

## Logiciels utilisés

L'ensemble des calculs ont été réalisés par le supercalculateur de l'IFREMER DATARMOR à l'aide des langages de programmation R [@RCoreTeam_2019] et Julia [@Bezanson_2017]. L'ensemble des packages et des libraires utilisés par ces deux langages sont présentés dans l'annexe [NDR Rajouter annexe].

## *Joint Species Distribution Models*

Les modèles de "distribution d'espèces conjointes" (*Joint Scpecies Distribution Models* ou *JSDM*) sont une évolution des modèles de distribution d'espèces (*Species Distribution Models* ou *SDM*). Contrairement à ces derniers, les *JSDM* se proposent de modéliser la distribution de toutes les espèces simultanément . De plus, ces méthodes incluent une structure de covariance particulière permettant d'avoir accès aux informations quant à la co-occurrence entre espèces [@warton2015; @Ovaskainen_2017a ; @Tikhonov_2019a].

### *HMSC*

Les calculs ont été réalisés avec le package *Hmsc* [@Tikhonov_2019b; @Hmsc_2019]. Trois modèles HMSC ont été créés : un premier sans l'inclusion de variables latentes, le second avec une seule variable latetente et le troisième comprenant trois variables latentes. La distribution Poisson Lognormal a été choisie pour les trois modèles. Chaque modèle dispose de quatre chaînes de Markov et chaque chaîne effectue 1,5 million d'itérations avant de se stopper. L’étape de *burning* supprime les 500 000 premières itérations de chaque chaîne.  Les chaînes sont échantillonnées toutes les mille itérations. Les priors par défaut ont été utilisés.

### PLN

Le modèle a été créé avec le package R *PLNmodels* [@Chiquet_2019]. Le modèle utilise une distribution de Poisson lognormal et aucun terme d'offset n'a été ajouté au modèle. 

### GLLVM

Le modèle a été créé avec le package R *gllvm* [@Niku_2019; @Gllvm_2019]. Le modèle utilise une distribution négative binomiale et vingt variables latentes. 

## Reconstruction des réseaux d'interactions

Les réseaux d'interactions sont reconstruits pour chaque modèle à grâce au package *EMtree*. Le principe de l'algorithme contenu dans ce package est d'inférer des interactions entre espèces en utilisant des arbres couvrants (graphes connectant tous les noeuds sans aucune boucle). La probabilité conditionnelle $P$ d'une arrête entre les espèces $j$ et $k$ est décrite dans ce modèle comme la somme des probabilités conditionnelles des arbres la contenant. Ainsi la probabilité qu'une arrête fasse partie du réseau d'intérêt est simplement sa probabilité conditionnelle moyennée par le nombre d'abers couvrant [@Momal_2020].

Pour mettre en place cet algorithme, le package maximise l'équation de log-vraisemblance suivante

$$L = \sum_{1\leq j < k \leq p} P_{jk} log\left(\beta_{jk}\widehat{\psi_{jk}}\right) - log \Beta - cst$$ {#eq:eq1}

où $\beta_{jk}$ est le poids contrôlant la probabilité de l'arrête ($j,k$) de faire partie du réseau d'interaction, $\Beta$ une constante de normalisation et $\widehat{\psi_{j,k}}$ qui résume l'information apporté par les données d'abondance à propos de l'arrête ($j, k$). Ainsi, les matrices de corrélations résiduelles interspécifiques de chaque modèle servent à initialiser l'algorithme pour les valeurs de $\widehat{\psi_{j,k}}$.

## Critères de comparaison entre les méthodes

### Validation croisée

Parmi les vingt-trois sites étudiés, trois ont été utilisés pour effectuer de la validation croisée sur les modèles. Deux sites présentent les deux habitats et le dernier présent uniquement des sédiments meubles. La performance des modèles a été comparée sur deux critères : la prédiction de l'abondance de chaque espèce et la prédiction de leur occurrence. 

### Comparaison des réseaux inférés

Les réseaux reconstruits sont comparés à l'aide des outils de la théorie des graphes appliqués aux graphes probabilistes [@Poisot_2015]. Ces outils sont issus du package EcologicalNetworks.jl [@Poisot_2019]. Quatre métriques ont été sélectionnées : le nombre de liens, la connectance, la centralité de Katz et l'emboitement.

### Validation par experts

Douze paires d'interactions ont été soumises à un panel de cinq experts en polychètes. Les experts ont évalué la vraisemblance de chaque interaction sur une échelle de 0 à 4 :

0. Ces deux taxa n'interagissent pas ;

1. Ces deux taxa ne peuvent probablement pas interagir ;

2. Pas d'avis sur l'interaction de ces deux taxa ;

3. Ces deux taxa peuvent probablement interagir ;

4. Ces deux taxa interagissent.

La concordance de l'avis des experts a été mesurée à l'aide du *Kappa de Fleiss* [@Fleiss1973]. Enfin, la corrélation entre l'avis moyen des experts et la probabilité moyenne des interactions calculées sur l'ensemble des modèles a été utilisée pour vérifier la prédiction de ces modèles.

# Resultats

# Discussion

# Bibliographie 

---
# Allow us te place the references where I want.
---

::: {#refs}
:::

# Annexes