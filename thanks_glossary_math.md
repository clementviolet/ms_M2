# Remerciements

Je souhaiterai remercier en premier lieu mon encadrant principal, Martin Marzloff pour avoir eu la gentillesse de m'accepter en stage à ses côtés. Je souhaite le remercier chaleureusement, lui et Aurélien Boyé pour avoir patiemment répondu à mes trop nombreuses questions tout au long de stage et pour les abondants commentaires qui ont grandement amélioré la qualité de ce manuscrit. Je remercie également Olivier Gauthier pour les heures de discussion passées à décortiquer les modèles dont il est question dans ce manuscrit, ces discussions m'ont permis d'encore approfondir mes connaissances en statistiques. Enfin Jacques Grall pour avoir répondu à mes questions sur la biologie et les interactions que peuvent entretenir ces animaux. Pour finir, je souhaiterai remercier tous les experts des polychètes que j'ai interrogés, sans qui une grande partie de ce travail n'aurait été possible.

# Notations mathématiques

**Indices**

|  Indice et plage de valeurs  |             Déscription         |
| :-------------------------- | :---------------------------|
| $i = 1, \dots, n$           |  Unité d'échantillonnage    |
| $j = 1, \dots, n_s$         |  Espèce                     |
| $r = 1, \dots, n_r$         |  Effet aléatoire            |
| $l = 1, \dots, n_l$         |  Variable latente

**Vecteurs et matrices**

|              Matrice        |                     Description                    |
| :-------------------------- | :------------------------------------------------- |
| $Y, y_{ij}$                 |  Abondances observées                              |
| $\hat{Y}, \hat{y}_{ij}$     |  Abondances estimées                               |
| $m$                         |  Abondances moyennes                               | 
| $X, x_{ij}$                 |  Données environnementales                         |
| $B, \beta_{ij}$             |  Coefficients associés à la niche environnementale |
| $Z, z_{ij}$                 |  Variables latentes (coordonnés de sites)          |
| $\Lambda, \lambda_{ij}$     |  Facteurs latents (coordonnés d'espèces)           |
| $\Omega, \omega_{ij}$       |  Corrélations résiduelles interspécifiques         |

**Fonction et distribution statistique**

|  Fonction / Distribution statistique  |             Description                           |
| :------------------------------------ | :------------------------------------------------ |
| $g(.)$                                |  Fonction de lien d'un modèle linéaire généralisé |
| $\mathcal L$                          |  Fonction de log-vraisemblance                   |
| $sgn(.)$                              |  Fonction signe                                   |
| $\mathcal P(.)$                       |  Distribution de Poisson log-normale              |
| $\mathcal N(.)$                       |  Distribution normale                             |

**Divers**

|     Divers     |              Description               |
| :------------- | :-------------------------------------------------------------- |
| $y_{.j}$       | Vecteur de l'abondance de l'espèce $j$ à travers tous les sites |
| $r_s$          | Corrélation de Spearman            |