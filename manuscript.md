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
filename: ms_m2
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

Le jeu de donnée utilisé dans ce travail est issu du *REseau de surveillance BENthique*. Ce réseau de surveillance a été créé en 1999 à la suite du naufrage du pétrolier Erika. Le but de ce réseau est d'acquérir des connaissances sur les habitats benthiques côtiers et de détecter des changements de la diversité biologique de ces habitats [NDR : Ajouter ref plaquette REBENT]. Ce sont six habitats benthiques différents  répartis sur l'ensemble des côtes bretonnes que surveille le *REBENT*.  Seulement deux de ces habitats ont été retenus pour comparer les trois cadres de modélisations : les herbiers de zostères et les sédiments meubles nus.

### Habitats

Les zostères phanérogames marines qui lorsque leur densité est forte, créent des "herbiers". En Bretagne, il existe deux espèces de zostères : la zostère marine (*Zostera marina*) et la zostère naine (*Zostera noltii*). Ces herbiers forment des habitats pour de nombreuses espèces. Ainsi, ces herbiers ont un rôle fonctionnel important pour beaucoup d'espèces en tant que zone de nurserie, de reproduction et de nourrissage. Le suivi du *REBENT* se concentre sur les herbiers de *Z. marina*, car cette espèce fait déjà partie du livre rouge des espèces menacées [NDR : ref plaquette REBENT + rapport 2016].

L'estran aux sédiments meuble se compose majoritairement de deux types de sédiments : des sédiments fins et des sédiments hétérogènes envasés. Les biocénoses à sables fins sont des biocénoses soumises à de fortes contraintes hydrodynamiques capables de brasser le sédiment, ce qui peut entrainer des modifications importantes des peuplements faunistiques. Les plages de sable fin servent d'habitats pour certaines espèces de bivalves, ou bien encore de zones de nurserie pour les poissons plats. Les biocénoses à sédiment hétérogène envasé se retrouvent principalement dans les baies et criques abritées de la houle. Cet habitat abrite des espèces de bivalves appréciés par les pécheurs à pied [NDR : ref plaquette REBENT + rapport 2016].

X sites le long de la façade bretonne ont été retenus. Certains présentent à la fois ces deux habitats comme le montre la carte. 

[insérer une carte des sites ici]

### Communauté faunistique

### Donnée environementales 

## *Joint Species Distribution Models*

### HMSC

### PLN

### GLLVM

## Reconstruction des réseaux d'interactions

## Critères de comparaison entre les méthodes

## Validation des méthodes

### Validation croisée

### Validation par experts

## Logiciels utilisés

L'ensemble des calculs ont été réalisé par le supercalculateur de l'IFREMER DATARMOR à l'aide des languages de programmation R [NDR : citation ]et Julia [@Bezanson_2017].

# Resultats

# Discussion

# Bibliographie 

---
# Allow us te place the references where I want.
---

::: {#refs}
:::

# Annexes