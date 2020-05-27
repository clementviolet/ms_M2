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
  - textheight=\paperheight
fontsize: 12pt
toc: true
linestretch: 1.5
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

L'écologie moderne s'intéresse particulièrement à la façon dont les espèces sont distribuées à la surface du globe. Des outils théoriques et pratiques ont ainsi été développés pour permettre de répondre à cette question. Les besoins d'une espèces pour persister peuvent par exemple être décrit par la niche écologique de Hutchinson, un hypervolume à n-dimemensions où chaque dimension représente une ressource ou une condition environnementale [@Hutchinson_1957]. Cette niche de Hutchinson peut être divisée en deux niches : la niche de Grinnell qui s'intéresse plus particulièrement aux conditions abiotiques nécessaires pour qu'une espèce persiste et la niche d'Elton qui se focalise principalement sur les interactions biotiques entre les individus [@Grinnell_1917; @Elton_2001].

Pour expliquer et prédire la distribution des espèces à l'aide de variables environnementales, des modèles nommés *Species Distribution model* (*SDM*) ont été créés. Ces modèles s'appuient sur les niches écologiques des espèces pour prédire leurs distributions. C'est ainsi que la niche de Grinnell "constitue la colonne vertébrale des modèles de distribution d'espèces" [@Gravel_2018].

## *Species-distribution model*

Le premier framework de *SDM* est apparu dans les années 80 avec le package *BIOCLIM*, mais depuis ces vingt dernières années, un réel engouement s'est créé autour de ce cadre de modélisation. Ce type de modèle est apprécié notamment grâce à son large cadre d'application qui s'étend au-delà de l'écologie des communautés et grâce aux progrès informatiques et mathématiques qui les rendent facile à mettre en oeuvre [@Ovaskainen_2020; @Araujo_2019]. 

|        *Single-species distribution model *             |     Référence    |  
| :------------------------------------------------------ | :--------------- |
| *Boosted regression trees* (*BRT*)                      | @dismo; @gbm     | 
| *Generalised additive model* (*GAM*)                    | @Wood_2011       |
| *Generalised linear model* (*GLM*)                      | @RCoreTeam_2019  |
| *Gradient nearset neighbour* (*GNN*)                    | @Crookston_2007  |
| *Maximum-entropy approach* (*MaxEnt*)                   | @Phillips_2006   |
| *Multivariate adaptive regression spline* (*MARS-COMM*) | @Milborrow_2017  |
| *Random forest* (*RF*)                                  | @Liaw_2002       |
| *Support vector machine* (*SVM*)                        | @Meyer_2019      |
| *Gradient extreme boosting* (*XGB*)                     | @Chen_2019       |
Table: Quelques-uns des modèles de *SDM* les plus populaires actuellement (adapté de @Ovaskainen_2020). {#tbl:sdm}

A l'origine ces modèles se contentaient de modéliser la distribution d'une seule espèce à la fois et sont qualifiés de *Single-species Distribution Models* (+@tbl:sdm). Toutefois, si la question de recherche s'intéresse à la communauté, il existe deux stratégies différentes pour modéliser la distribution des espèces la composant. Il est possible prédire la distribution des espèces chacune de leur côté et de les assembler en communauté ensuite (*Stack Species Distribution Model* ou *SSDM*), ou bien de  prédire la distribution des espèces et les assembler en même temps (*Joint Species Distribution Model*) [@Ferrier_2006]. La différence majeure entre les deux méthodes est que les *SSDMs* ne tiennent pas compte du filtre biotique que les espèces exercent les unes sur les autres [@Zurell_2019]. Au contraire, les *JSDMs*  ont été développés en prenant en compte la co-occurrence qui existe entre les espèces, permettant de modéliser à la fois la distribution d'une espèce en particulier et de toute la communauté en tenant compte du filtre biotique [@warton2015]. Cette structure de co-occurrence particulière permet d'inférer de manière plus ou moins directe les interactions entre espèces [@Ovaskainen_2017b]. De plus, comme les *JSDMs* modélisent toute la communauté en une seule fois, ces modèles sont moins à risque de surapprentissage que les *SSDM*.

## Joint Species Distribution Model

Les *JSDMs* présentés dans le +@tbl:jsdm sont tous des extensions multivariées à variables latentes des modèles linéaires généralisés classiques [@Hui_2016 ; @Ovaskainen_2017a; @Niku_2019; @Chiquet_2019]. Un modèle à variables latentes (*LVM*) simple peut être écrit comme suit :

$$ y_{ij} = g\left(m_{ij}\right) = x_i \times \beta_j + Z_i \times \lambda_j $${#eq:lvm} 

La résolution de cette équation est possible si l'on admet des contraintes additionnelles telles que par exemple [@warton2015] : 
$$\left(Z_i \times \lambda_j\right) \sim N\left(0, \Omega\right)$$ {#eq:lvmconst}

Et que la matrice de covariance $\Omega$ est égale à :

$$\Omega = \lambda \lambda^\prime$$ {#eq:loadings}
Ainsi, les *LVMs* permettent de prendre en compte des éventuelles variables explicatives manquantes tout en estimant la corrélation entre espèces. Un autre avantage des variables latentes est que l'estimation de matrice de corrélation entre espèces est plus simple que par rapport à un modèle linéaire à effets mixtes généralisés. La matrice de coordonnés des espèces ($\lambda$) dans le cas d'un *LVM* a au plus autant de colonnes que de variables latentes (+@eq:lvmconst et @eq:loadings), tandis que dans le cas d'un modèle linéaire à effets mixte généralisé celle-ci à autant de colonnes que d'espèces [@warton2015]. Ainsi, le nombre de variables latentes utilisées par le modèle est donc un paramètre crucial, puisqu'il permet de faire un compromis entre précision de la matrice de corrélation résiduelle et la réduction du temps de calcul et des degrés de libertés utilisés [@warton2015].

|              *Joint species distribution model*           |     Référence     |
| :-------------------------------------------------------- | :---------------- |
| *Bayesian ordination and regression analysis* (*BORAL*)   | @Hui_2016         |
| *Hierachical modelling of Species Communities* (*HMSC*)   | @Ovaskainen_2017a |
| *Generalized linear latent variable models* (*GLLVM*)     | @Niku_2019        |
| *Poisson lognormal model* (*PLN*)                         | @Chiquet_2019     |
Table: Quelques uns des modèles de *JSDM* (adapté de @Ovaskainen_2020). {#tbl:jsdm}

### *Hierachical modelling of Species Communities*

*HMSC* est un modèle mixte linéaire généralisé, hiérarchique et multivarié, ajusté par inférence bayésienne [@Ovaskainen_2020]. Ce cadre de modélisation rend possible l'utilisation de traits et de la phylogénie pour ajuster les niches abiotiques des taxa. La particularité de ce modèle est qu'il est hiérarchique, ainsi chaque effet aléatoire donne lieu à sa propre matrice de corrélation résiduelle [@Ovaskainen_2017a]. L'+@eq:hmsc présente la formulation mathématique d'un modèle n'utilisant que des variables environnementales et un nombre $n_r$ d'effets aléatoires. En plus des effets aléatoires classiques, ce cadre de modélisation permet de prendre en compte des effets aléatoires spatiaux et temporels (ces derniers sont traités comme un cas particulier d'effet aléatoire spatiale à une seule dimension).

$$ y_{ij} = g\left(m_{ij}\right) = x_i \times \beta_j + \sum_{r = 1}^{n_r} Z_{ir} \times \lambda_{rj} $$ {#eq:hmsc}

Etant un modèle bayésien, la distribution a posteriori est échantillonné grâce à la méthode MCMC [@Ovaskainen_2017b]. L'utilisation de l'inférence bayésienne permet à l'utilisateur de ne pas spécifier le nombre de variables latentes à utiliser pour chaque effet aléatoire. Le modèle ajuste le nombre de variables latentes pour que celles non significatifs soient tronquées [@Ovaskainen_2020].

### *Generalized linear latent variable models*

GLLVM est un modèle mixte linéaire généralisé et multivarié ajusté par la méthode du maximum de vraisemblance. Ce cadre de modélisation prend en compte l'utilisation de variables environnementale et peut également inclure des traits. Un modèle ajusté avec ce type de modèle sans traits peut être écrit comme l'+@eq:lvm. Ce modèle présente une manière innovante de maximiser la vraisemblance en utilisant une approximation variationnelle gaussienne de la log-vraisemblance pour le cas où la fonction de lien serait des données de comptage surdispersé, binaires ou encore ordinales [@Niku_2019]. Cette méthode de maximisation de la log-vraisemblance permet d'accélérer les calculs. Comparativement à Boral [@Hui_2016], *GLLVM* peut réaliser les mêmes calculs en quelques minutes au lieu de quelques heures. Contrairement à HMSC, *GLLVM demande à l'utilisateur de choisir le nombre de variables latentes qu'utilisera le modèle [@Gllvm_2019].

### *Poisson lognormal model*

Le modèle de Poisson lognormal est modèle linéaire mixte et multivarié. Il ne peut modéliser qu'une seule sorte de distribution : la distribution (conditionnelle) de Poisson lognormal +@eq:pln [@Aitchison_1989; @Chiquet_2019]. Un modèle simple avec uniquement des variables environnementales peut être écrit de cette façon :

$$y_{ij}|Z_{ij} \sim P\left(exp\left\{x_i \times \beta_j + Z_{ij}\right\}\right)$$ {#eq:pln}

Le vecteur latent $Z_i$ prend en compte les variations d'abondance non expliquées par les variables environnementales incluses dans le modèle [@Momal_2020]. Cette variable latente agit comme un effet aléatoire lié au site [@Momal_2020]. Dans ce cadre de modélisation, il y a autant de variables latentes différentes qu'il y a d'espèces et la distribution de cette variable latente est paramétrisée de la manière suivante :

$$Z_i \sim N\left(0_{n_s}, \Omega^{-1}\right) $$ {#eq:constpln}

---
## Reconstruction de réseaux d'interactions
#
#Tous les modèles de *JDSM* présentés ci-dessus permettent d'accéder à la corrélation résiduelle entre espèces grâce aux variables latentes inclues dans les modèles [@warton2015]. Mais reconstruction de graphe d'interaction à partir des données d'abondance ajustés par les *JSDM* pose problème puisque les données d'abondance peuvent avoir une large gamme de valeurs et ces données ne suivent pas une distribution normale [@Momal_2020].
#
#Pour surmonter ces difficultés, nous avons utiliser une méthode nommé *EMtree* qui se base sur les arbres couvrants (graphes connectant tous les noeuds sans aucune boucle) [@Momal_2020]. Cette méthode permet de définir la probabilité condtionnelle d'un lien entre deux espèces comme la somme des probabilités des arbres couvrant contenant cette interaction. 
#
#Le principe de l'algorithme contenu dans ce package est d'inférer des interactions entre espèces en utilisant des arbres couvrants (graphes connectant tous les noeuds sans aucune boucle). La probabilité conditionnelle $P$ d'une arrête entre les espèces $j$ et $k$ est décrite dans ce modèle comme la somme des probabilités conditionnelles des arbres la contenant. Ainsi la probabilité qu'une arrête fasse partie du réseau d'intérêt est simplement sa probabilité conditionnelle moyennée sur l'ensemble des arbres couvrant [@Momal_2020].
#
#Pour mettre en place cet algorithme, le package maximise l'équation de log-vraisemblance suivante
#
#$$L = \sum_{1\leq k < l \leq p} P_{kl} log\left(\beta_{kl}\widehat{\psi_{kl}}\right) - logB - cst$$ {#eq:emtree}
#
#où $\beta_{kl}$ est le poids contrôlant la probabilité de l'arrête ($k,l$) de faire partie du réseau d'interaction, $B$ une constante de normalisation et $\widehat{\psi_{j,k}}$ qui résume l'information apporté par les données d'abondance à propos de l'arrête ($k, l$). Ainsi, les matrices de corrélations résiduelles interspécifiques issues de chaque modèle servent à initialiser l'algorithme pour les valeurs de $\widehat{\psi_{k,l}}$.
#En ecologie on s'intéresse à comment les espèces sont répartis à la surface du globe. Histoire des niches écologique. Elles peuvent être soumises à des contraintes qui s'accentuent par l'homme. Besoin de modèle pour comprendre la distribution et l'impact des changements des conditio env. Nouveaux modèles développé ces cinq dernères années les JSDM. Ces méthodes ont été développé sur des concepts tirés de l'écologie des communautés végétales. Hors, les communautés benthiques subissent des contraintes environmentales beaucoup plus fortes (variation journalière de salinité, temp, UV, etc liés aux marées.). Est-ce que ces méthodes sont applicables aux communautés benthiques ? Pour cela test de trois cadre de modèles avec au total 5 modèles sur des données d'abondance de polychètes issus de deux milieux différents : les herbiers de *Zostera marina* et les estran à sédiment meubles.
---
## Cas d'étude

Le nombre croissant de modèles de distribution d'espèces amène à se questionner sur la performance de ces derniers [@Norberg_2020]. De plus, Les *JSDM* développés ses dernières années ont fortement été influencées par les théories de distribution des espèces issues de l'écologie végétale [@warton2015]. Cette base théorique ancré dans l'écologie végétale amène à se questionner sur leur performance en écologie marine. 

Les communautés benthiques sont très différentes dans le fonctionnement des communautés végétales [NDR: ref]. En effet, les communautés benthiques vivant dans la zone de balancement des marées sont soumises à des contraintes environnementales variant brusquement. A marée basse par exemple, la salinité et la température peuvent augmenter rapidement les jours de beau temps. Au contraire, les jours de pluie, la marrée basse peut aussi entrainer un stress osmotique sur les organismes benthiques intertidaux en diminuant fortement la salinité [NDR : refs]. 

C'est pourquoi évaluer la capacité de ces différents modèles à s'ajuster aux communautés benthiques marines est important avant de les utiliser. Ce travail s'intéresse à la comparaison du framework *Hierachical modelling of Species Communities* (*HMSC*), décrit comme l'un des meilleurs modèles actuels d'après @Norberg_2020 et de deux autres encore non évalués dans la littérature. Ces deux frameworks sont *Generalized linear latent variable models* (*GLLVM*) et *Poisson lognormal model* (*PLN*). Bien que certains modèles puissent prendre en compte des données comme les traits biologiques ou la phylogénie, ce travail ne s'intéressera qu'à l'utilisation de variables environnementales dans ces modèles. La comparaison s'est faite sur les capacités de prédiction de l'abondance et de la richesse spécifique, ainsi que de la qualité des réseaux d'interactions reconstruits par les différentes méthodes.

Le jeu de donnée utilisé dans ce travail est issu du *REseau de surveillance BENthique*. Ce réseau de surveillance a été créé en 1999 à la suite du naufrage du pétrolier Erika. Le but de ce réseau est d'acquérir des connaissances sur les habitats benthiques côtiers et de détecter des changements de la diversité biologique de ces habitats [@Rebent2016]. Ce sont six habitats benthiques différents  répartis sur l'ensemble des côtes bretonnes que surveille le *REBENT*. Ce protocole de suivis se concentre sur la macrofaune (> 1mm) et la méthodologie détaillée est présentée dans @Boye_2019. Seulement deux de ces habitats ont été retenus pour comparer les trois méthodes de modélisations : les herbiers de zostères et les sédiments meubles nus.

### Habitats

Les zostères sont des phanérogames marines qui lorsque leur densité est forte, créent des "herbiers". En Bretagne, il existe deux espèces de zostères : la zostère marine (*Zostera marina*) et la zostère naine (*Zostera noltii*). Ces herbiers forment des habitats pour de nombreuses espèces. Ils ont un rôle fonctionnel important pour beaucoup d'espèces en tant que zone de nurserie, de reproduction et de nourrissage [@Lefcheck_2019; @McDevitt_Irwin_2016]. Cet habitat est connu pour sa plus grande richesse spécifique par rapport à d'autres habitats comme les sédiments meublent nus [@Hily_1999; @Boye_2017; @Sunday_2016]. Le suivi du *REBENT* se concentre sur les herbiers de *Z. marina*, car cette espèce fait déjà partie du livre rouge des espèces menacées [@Rebent2016; @Waycott_2009]. Toutefois, les mesures de protections mise en place vis-vis de cet habitat semblent porter leurs fruits en Europe [@de_los_Santos_2019].

Les plages de sable de abritent des communautés dominées par les crustacés les mollusques et les polychètes [@Defeo_2005]. Cet habitat est contraint principalement par trois facteurs abiotiques : les marées, la houle et le sédiment. L'interaction entre ces trois facteurs crée un grand éventail de plages différentes : de la plage où la mer ne se retire que très peu à marée basse aux plages dont de vastes étendues de sable sont découvertes lors des grandes marées [@Defeo_2005]. La richesse spécifique sur ces plages est fortement influée par la hauteur des marées et dans une moindre mesure par la température de l'eau et la taille des sédiments [@Defeo_2013; @Defeo_2017].  Ces plages de sable fin ont aussi un rôle écologique important de nurserie pour de nombreuses espèces de poissons plats [@Quillien_2017]. Toutefois, les plages de sable sont des biocénoses menacées. Ce sont des habitats à la fois menacés par les changements globaux (hausse du niveau des mers, érosion...) et par les activités anthropiques telles que l'urbanisme ou bien les activités récréatives [@Defeo_2009].

### Communauté faunistique

La communauté faunistique d’intérêt dans ce travail est celle des polychètes. Les polychètes sont des animaux marins du phylum des annélides [@Lecointre_2001]. Cette classe a été choisie, car les animaux la composant ont des modes de vie très divers [@Boye_2019]. Il est classique de catégoriser les polychètes en plusieurs groupes en fonction de leurs modes de vie : certains sont nageurs, ou tubicoles, ou bien encore benthiques fouisseurs. Leurs régimes alimentaires sont aussi très variés, il existe des polychètes prédateurs, mais également des suspensivores ou psamivores [@Jumars_2015].

# Matériel et méthode

## Cas d'étude

### Jeu de données

### Communauté faunistique

La communauté faunistique d’intérêt dans ce travail est celle des polychètes. Les polychètes sont des animaux marins du phylum des annélides. Cette classe a été choisie, car les animaux la composant ont des modes de vie très divers. Il est classique de catégoriser les polychètes en plusieurs groupes en fonction de leur habitat : certains sont nageurs, ou tubicoles, ou bien encore benthiques fouisseurs. Leurs régimes alimentaires sont aussi très variés, il existe des polychètes prédateurs, mais également des suspensivores ou psamivores [@Lecointre_2001].

### Données environnementales 

Six variables environnementales ont été sélectionnées (tableau : {@tbl:env}). La salinité, la température et la vitesse des courants proviennent de la base de données publique *PREVIMER* basée sur les résultats des modèles de *MARS3D*. Le fetch a été calculé à partir des polygones terrestres disponibles dans *OpenStreetMap*. Les variables granulométriques ont été échantillonnées *in situ* (protocole détaillé dans @Boye_2017). Chaque variable environnementale a été centrée et transformée en polynôme de degrés un avant d'être utilisé par les différents modèles. 

|  Abréviation  |     Définition                             |    Unité    |
| :-----------: | :----------------------------------------: | :---------- |
|   Average     |    Fetch moyen                             |     Km      |  
|   MO          |   Concentration en Matière organique       |   %         |
|   SAL_sd_w    | Ecart-type de la salinité de l'eau         | PSS-78      |
|   TEMP_sd_w   | Ecart-type de la température de l'eau      | °C          |
|   CURR_mean_w | Force moyenne des courants                 | m.s^-1^     |
|   mud         | Concentration de boue dans les sédiments   | %           |
|   Trask_So    | Indice de Trask - Homogénéité du sédiment  | Aucune      |
Table: Variables environnementales utilisées par tous les modèles. {#tbl:env}

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

| Nom du modèle | Framework | Distribution statistique |            Nombre variables latentes            |
| :------------ | :-------- | :----------------------- | :---------------------------------------------- |
| HMSC_reg      | HMSC      | Poisson lognormal        | 0                                               |
| HMSC_samp     | HMSC      | Poisson lognormal        | 1                                               |
| HMSC_hier     | HMSC      | Poisson lognormal        | 3                                               |
| PLN           | PLN       | Poisson lognormal        | 1                                               |
| GLLVM         | GLLVM     | Negative binomial        | 20                                              |
Table: Descriptif des modèles utilisés. {#tbl:summarymod}

## Reconstruction des réseaux d'interactions

Les réseaux d'interactions sont reconstruits pour chaque modèle à grâce au package *EMtree*. Le principe de l'algorithme contenu dans ce package est d'inférer des interactions entre espèces en utilisant des arbres couvrants (graphes connectant tous les noeuds sans aucune boucle). La probabilité conditionnelle $P$ d'une arrête entre les espèces $j$ et $k$ est décrite dans ce modèle comme la somme des probabilités conditionnelles des arbres la contenant. Ainsi la probabilité qu'une arrête fasse partie du réseau d'intérêt est simplement sa probabilité conditionnelle moyennée par le nombre d'abers couvrant [@Momal_2020].

Pour mettre en place cet algorithme, le package maximise l'équation de log-vraisemblance suivante

$$L = \sum_{1\leq j < k \leq p} P_{jk} log\left(\beta_{jk}\widehat{\psi_{jk}}\right) - logB - cst$$ {#eq:emtree}

où $\beta_{jk}$ est le poids contrôlant la probabilité de l'arrête ($j,k$) de faire partie du réseau d'interaction, $B$ une constante de normalisation et $\widehat{\psi_{j,k}}$ qui résume l'information apporté par les données d'abondance à propos de l'arrête ($j, k$). Ainsi, les matrices de corrélations résiduelles interspécifiques de chaque modèle servent à initialiser l'algorithme pour les valeurs de $\widehat{\psi_{j,k}}$.

## Critères de comparaison entre les méthodes

### Pouvoir explicatif

Le pouvoir explicatif de chaque modèle pour chaque taxon est donné par une mesure de pseudo-*R^2^*, dénommé après *SR^2^*. Pour les modèles de Poisson, le *SR^2^* est basé sur la mesure de la corrélation de Spearman entre les données d'abondance observées et prédites [@Ovaskainen_2020]. Cette mesure est calculée de la façon suivante pour l'espèce $j$ :

$$ SR^2_j = sgn\left(r_s\left(y_{.j}, \hat{y}_{.j}\right)\right) \times r_s\left(y_{.j}, \hat{y}_{.j}\right)^2 $$ {#eq:eq2}

### Validation croisée

Parmi les vingt-trois sites étudiés, trois ont été utilisés pour effectuer de la validation croisée sur les modèles. Deux sites présentent les deux habitats et le dernier présent uniquement des sédiments meubles. La performance des modèles a été comparée sur deux critères : la prédiction de l'abondance de chaque espèce et la prédiction de leur occurrence. 

### Prédiction de l'abondance

Chaque modèle entrainé a été utilisé pour prédire l'abondance des espèces présentent dans les trois sites de validation. La qualité de la prédiction a été évaluée par l'erreur quadratique moyenne (*RMSE*).

#### Prédiction de l'occurrence

Pour prédire l'occurrence de chaque espèce à partir des données d'abondance, un seuil a été établi. Une espèce est considérée comme présente dans un site dès lors que son abondance est supérieure ou égale à celle qui maximise le J de Youden dans l'espace de la courbe *ROC*. Cette statistique du *J de Youden* a été utilisée, car elle prend en compte à la fois la sensibilité et la spécificité.

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

Avant de regarder les résultats des différents modèles du framework *HMSC*, la validité de ces modèles a été inspectée. La bonne convergence des chaînes a été vérifiée à l'aide de l'outil de diagnostic de Gelman-Rubin [@Gelman_1992]. Enfin, le nombre d'échantillons indépendants pour chaque paramètre était satisfaisant.  

## Coût de calcul

Les calculs pour tous les modèles ont été réalisés sur l'hypercalculateur de l'IFREMER DATARMOR. Le processeur de chaque noeud de calculs du cluster HPC est un CPU Intel E5-2680 v de 14 coeurs cadencés à 2,40 GHz. Chaque modèle n'utilisait pas plus d'un seul coeur. *HMSC_hier* est le modèle le plus coûteux en termes de temps de calcul et *GLLVM* est le modèle le plus coûteux en ce qui concerne la mémoire vive (+@tbl:coutcalc). 

|     Modèle     |   Temps de calcul (h : mn)   |      RAM (Go)    |
| :------------- | :--------------------------: | :--------------: |
| *HMSC_reg*     | $25:27$                      | $0,49$           |
| *HMSC_samp*    | $170:56$                     | $0,69$           |
| *HMSC_hier*    | $457:50$                     | $0,73$           |
| *PLN*          | $00:03$                      | $0,37$           |
| *GLLVM*        | $13:43$                      | $68,1$           |

Table: Coût de calculs des différents modèles. {#tbl:coutcalc}

Le temps de calcul pour les modèles *HMSC* dépend fortement de la taille des données d'abondance faunistique, du nombre de variables explicatives, mais surtout dans ce cas-ci de la structure des effets aléatoires inclus. De plus, l'ajustement de modèles par la méthode *MCMC* est aussi une opération très couteuse en puissance de calculs. Toutefois, le temps de calcul peut être réduit en faisant tourner les chaînes de Markov en parallèle. Cette solution n'a pas pu être mise en oeuvre à cause de bugs informatiques.

Le coût en mémoire vive de *GLLVM* s'explique par la manière dont sont sauvegardés les paramètres de la régression : à eux seuls, ils pèsent un peu moins de 43 Go. Ce poids peut être réduit en diminuant le nombre de variables latentes utilisées, ce qui réduit en même temps du temps de calcul.

*PLN* quant à lui est le modèle le plus économe en termes de coût de calculs, notamment grâce à sa structure de variable latente qui n'inclue qu'un seul effet aléatoire.

## Pouvoir explicatif

Les modèles ayant le meilleur pouvoir explicatif sont les modèles *HMSC* ayant des effets aléatoires (+@fig:SR2). Ces deux modèles semblent très proches quant à leur pouvoir explicatif. Leur *SR^2^* moyens sont supérieur à $0,2$ et leur *SR^2^* médian proche de $0,2$. Pour ces deux modèles, le même taxon est le expliqué avec un *SR^2^* proche de $0,8$. Les taxa les mieux expliqués sont communs à ces deux modèles. Néanmoins, ces performances en terme de pouvoir explicatif sont à mettre en perspective du grand nombre d'espèces étant faiblement expliqués par ces deux modèles.

![Distribution du SR^2^ pour chaque modèle. Les points rouges représentent la valeur moyenne du *SR^2^* pour chaque modèle. Les points noirs représentent les espèces, dont le *SR^2^* $>1.58\times IQR/\sqrt{n}$.](figures/SR2-density-method-2.png){#fig:SR2}

Les modèles *HMSC_reg*, *PLN* et *GLLVM* sont quant à eux moins performant pour expliquer la distribution des espèces de polychètes (+@fig:SR2). Leur *SR^2^* médian et moyen est proche de $0.1$. Ici encore, il est possible de remarquer que la distribution des *SR^2^* est comparable et que ce sont les mêmes taxa qui sont les mieux expliqués par ces différents modèles. Il est à noter que le modèle *HMS_reg* ne partage qu'une seule espèce très bien expliquée avec les deux autres modèles *HMSC* : *Aonides oxycephala*. De plus, *Aonides oxycephala* ne fait pas parti des espèces les mieux expliquées par les modèles *PLN* et *GLLVM*.

## Effets de l'environnement

Les espèces les mieux expliquées par les modèles sont principalement des taxa très communs et abondants (+@fig:effectenv). Ce sont des taxa ubiquistes ou des espèces inféodés aux sables fins comme *Magelona filiformis* ou encore *Melinna palmata*. Certains taxa dont la classification taxonomique est mal connue (*Lumbrineris spp.* ou bien *Acromegalomma spp.*) sont aussi bien expliqués, cela est dû notamment à leur forte abondance. Il est possible de remarquer que moins les espèces sont bien expliquées par les modèles, plus l'effet des variables environnementales est faiblement positif ou négatif. 

![Effets des variables environnementales sur l'abondance des différentes espèces de polychètes. Les variables et les abondances sont centrées et réduites. Les espèces sont ordonnées par $SR^2$ moyen décroissant. Les variables environnementales sont ordonnées par proportion de variances expliquées décroissante (voir +@tbl:env pour leur description).](figures/beta-all-plot-2.png){#fig:effectenv}

Les variables environnementales expliquant respectivement le plus et le moins de variances (*Average* et *Trask*) sont également celles qui ont l'effet le plus constant à travers les différents modèles. Il est toutefois possible de remarquer qu'il y a un changement de signe pour l'effet de la variable Trask entre les modèles *HMSC_samp* et *HMSC_hier* pour les espèces les mieux expliquées. Ce changement de signe est cohérent avec l'augmentation du nombre d'effets aléatoire pour le modèle *HMSC_hier*, ces nouveaux effets captent une plus grande partie de la variance qui était auparavant expliquée par les variables environnementales. De plus, ce changement de signe est cohérent avec la biologie des taxa les mieux expliqués. Un grand nombre d'entre eux préfèrent les sédiments fins et homogènes. Ainsi, leur abondance diminue lorsque l'hétérogénéité du sédiment augmente, expliquant l'effet négatif de la variable *Trask*.

## Validation croisée

### Occurence

Grâce aux trois sites conservés pour la validation croisée, il a été possible de faire la comparaison de la performance de la prédiction de la richesse spécifique (+@fig:predocc et +@tbl:RMSEocc).

![Richesse spécifique observée face à la richesse spécifique prédite par les différents modèles. Le point rouge représente la richesse moyenne.](figures/rmse-pred-abundance-occurence-2.png){#fig:predocc}

Les deux modèles sont les modèles ayant comprenant le plus de variables latentes : *GLLVM* et *HMSC_hier*. *GLLVM* semble sous-estimer la richesse observée par rapport aux valeurs observées et par rapport aux autres modèles. *HMSC_hier* quant à lui surestime la richesse, mais la distribution de la richesse prédite par ce modèle couvre une grande gamme de valeur de la richesse observée. Les modèles contenant qu'une seule variable latente ou n'en contenant pas sont les modèles les moins performants. Ils surestiment la richesse observée.

|Method      | Min|     Q1| Median|  Moy   |     Q3|   Max|
|:-----------|:---|:------|:------|:-------|:------|:-----|
|*GLLVM*     | $0$|  $3,0$|    $7$|  $7,63$| $10,0$|  $29$|
|*HMSC_hier* | $1$| $11,5$|   $16$| $15,37$| $20,0$|  $33$|
|*PLN*       | $4$| $21,0$|   $27$| $27,28$| $33,0$|  $51$|
|*HMSC_reg*  | $6$| $25,0$|   $33$| $32,84$| $40,5$|  $56$|
|*HMSC_samp* | $4$| $18,5$|   $30$| $29,65$| $38,5$|  $62$|
Table: Statistiques descriptives du *RMSE* de la richesse spécifique par modèle. Les modèles sont classés par ordre croissant de *RMSE* maximal. Q1 et Q3 représentent respectivement le premier et troisième quartile du *RMSE* de chaque modèle. {#tbl:RMSEocc}

Si l'on s'intéresse maintenant à la prédiction de l'abondance en fonction des années, des sites et des habitats, il est possible de remarquer *HMSC_hier* semble être le modèle qui arrive le mieux à prédire les changements de richesses spécifiques (+@fig:occpred). C'est le seul modèle qui suit la tendance à la diminution de la richesse spécifique dans les herbiers de l'Arcouest ainsi que dans les herbiers de Sainte-Marguerite en 2009. Pour les sédiments nus, les prédictions de la richesse semblent être plus difficiles à réaliser, aucun modèle n'a su prédire l'augmentation rapide de la richesse spécifique observée en 2009 à Sainte-Marguerite (+@fig:occpred).
 
![Prédiction de l'occurence pour l'abondance corrigé par le J de Youden](figures/roc-richness-prediction-3.png){#fig:occpred}

### Abondance

Aucun modèle ne parvient à prédire de manière satisfaisante l'abondance des espèces à chaque site (+@tbl:RMSEabund). Le modèle le moins mauvais est le modèle *HMSC_hier* dont la pire valeur de RMSE pour une espèce est de l'ordre de $10^4$. Bien que cette erreur soit importante, elle est négligeable fasse à la plus faible du modèle GLLVM dont la plus faible valeur de RMSE est de l'ordre de $10^31$. 

|Method    |        Min|         Q1|     Median|       Mean|         Q3|        Max|
|:---------|:----------|:----------|:----------|:----------|:----------|:----------|
|HMSC_hier | $2,40\times 10^{01}$| $2,41\times 10^{02}$| $6,77\times 10^{02}$| $3,63\times 10^{03}$| $2,37\times 10^{03}$| $4,13\times 10^{04}$|
|HMSC_samp | $3,40\times 10^{01}$| $1,00\times 10^{03}$| $3,02\times 10^{03}$| $6,53\times 10^{03}$| $7,57\times 10^{03}$| $4,36\times 10^{04}$|
|PLN       | $1,70\times 10^{04}$| $2,81\times 10^{04}$| $3,71\times 10^{04}$| $3,99\times 10^{04}$| $4,53\times 10^{04}$| $8,59\times 10^{04}$|
|HMSC_reg  | $9,60\times 10^{02}$| $5,07\times 10^{03}$| $1,26\times 10^{04}$| $2,19\times 10^{04}$| $1,81\times 10^{04}$| $3,37\times 10^{05}$|
|GLLVM     | $1,25\times 10^{31}$| $9,14\times 10^{32}$| $7,68\times 10^{34}$| $1,09\times 10^{36}$| $3,51\times 10^{35}$| $8,22\times 10^{36}$|
Table: Statistiques descriptives du *RMSE* de l'abondance par modèle. Les modèles sont classés par ordre croissant de *RMSE* maximal. Q1 et Q3 représentent respectivement le premier et troisième quartile du *RMSE* de chaque modèle. {#tbl:RMSEabund}

## Résaux reconstruits

### Analyse des graphes

Pour tous les modèles incluant au moins une variable latente, un réseau a été reconstruit grâce à la matrice de $\Omega$. Pour la méthode HMSC_hier, un réseau par effet aléatoire a été reconstruit, chaque effet aléatoire ayant sa propre matrice $\Omega$. Un méta-réseau moyennant les probabilités de chaque méthode a également été créé. L'ensemble des différents réseaux sont représentés en annexe.

Tous ces réseaux probabilistes présentent le même nombre de liens $l$. Toutefois la variance du nombre de liens est légèrement plus importante chez les réseaux du modèles *HMSC_hier*. La connectance $C$ est quasiment identique pour tous les modèles. L'imbrication $\eta$ des réseaux est quasi-nulle ($\eta \in [0;1]$).

|Méthode           | $l$   | $Var(l)$|      $C$    | Var($C$)      |    $\eta$|
|:-----------------|:-----|:---------|:-----------|:---------------|---------:|
|HMSC_samp         |   182|  161.2572|   0.0217391|       0.0000023| 0.0320728|
|HMSC_hier_annee   |   182|  171.6276|   0.0215028|       0.0217391| 0.0277452|
|HMSC_hier_site    |   182|  155.2447|   0.0215028|       0.0217391| 0.0334290|
|HMSC_hier_habitat |   182|  171.9385|   0.0215028|       0.0217391| 0.0272676|
|HMSC_hier_moyen   |   182|  170.7823|   0.0215028|       0.0217391| 0.0272676|
|GLLVM             |   182|  156.5237|   0.0215028|       0.0217391| 0.0425502|
|PLN               |   182|  158.8137|   0.0217391|       0.0000022| 0.0421982|
|Moyen             |   182|  168.4255|   0.0215028|       0.0000024| 0.0325868|

L'avis des experts du taxon des polychètes sur le réseau moyen est que le réseau moyen est assez intéressant d'un point de vue biologique (+@fig:meannet). Il laisse paraître des interactions proies-prédateurs comme celles entre *Perinereis cultrifera* et *Lumbrineris spp.*, *Magelona filiformis* et *Sigalion mathildae* ou bien encore *Scalibregma celticum* et *Sthenelais boa*. La probabilité d'interaction forte entre *Platynereis dumerilii* et *Euclymene spp.* et entre *Notomastus latericeus* pourrait traduire de la compétition. *Platynereis dumerilii* est un brouetteur de microphyto benthos et les deux autres espèces sont des déposivores. Ces taxa pourraient entrer en compétition pour l'espace. De plus, ces trois taxa sont également ceux avec la plus grande centralité du réseau moyen, cette importante dans le réseau est peut-être liée à la forte dominance des espèces déposivores ou brouetteuses dans cette communauté.

![Réseau reconstruit à l'aide des probabilités moyennes de chaque méthode. Les points rouges représentent les taxa de polychètes retrouvés dans les deux habitats, les verts retrouvés uniquement dans les herbiers et les bleus dans les sédiments meubles. Seul les arrête ayant une probabilité $p > 0.2* sont affichés.L'opacité des arrêtes est proportionnelle à leur probabilité. L'opacité des points est proportionnelle à leur importance dans le réseau.](figures/mean-network-1.png){#fig:meannet}

### Avis des experts du taxon des polychètes

Besoin de discuter avec vous là-dessus.

# Discussion

# Bibliographie 

---
# Allow us te place the references where I want.
---

::: {#refs}
:::

# Annexes