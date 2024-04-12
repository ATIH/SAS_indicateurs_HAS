# SAS_indicateurs_HAS

# Programmes et spécifications des indicateurs de résultats en chirurgie orthopédique

Les indicateurs de résultats en chirurgie orthopédique mesurent les évènements thrombo-emboliques (ETE) et les infections du site opératoire (ISO) après pose de prothèse totale de hanche (PTH) ou pose de prothèse totale de genou (PTG).

Ce dépôt contient les programmes SAS et les spécifications utilisées pour calculer ces 4 indicateurs (ETE-PTH, ETE-PTG, ISO-PTH et ISO-PTG) à partir du PMSI MCO, lors de la campagne 2022 sur les données 2021.

Les programmes ont été développés par le service DATA de l'Agence technique de l'information sur l'hospitalisation(ATIH), en déclinant les spécifications fournies par le service Evaluation et Outils pour la Qualité et la Sécurité des Soins (EvOQSS) de la Haute Autorité de Santé (HAS).


## Précisions sur les utilisations possibles des programmes selon la source de données utilisée :

A partir du PMSI national chainé, le programme permet :
- d’identifier la population cible (inclusions/exclusions). Certains critères d’exclusion de la population cible ainsi que des facteurs d’ajustement nécessitent l’accès au PMSI chainé. 
- de calculer le nombre d’ISO ou d’ETE total, de chiffrer les ISO/ETE détectées lors du séjour cible sans faire le lien avec le PMSI local. Pour faire le lien avec le PMSI local, il faut une autorisation CNIL.
- de chiffrer les ISO détectées lors d’une réhospitalisation dans l’établissement où a été posée la PTH ou PTG. Pour faire le lien avec le PMSI local, il faut une autorisation CNIL.

A partir du PMSI local : Il est possible de ré-utiliser en partie et en les adaptant les programmes, pour :
- identifier une partie de la population cible (inclusions/exclusions). Certains critères d’exclusion de la population cible ainsi que des facteurs d’ajustement nécessitent l’accès au PMSI national chainé.
- calculer le nombre d’ISO/ETE lors du séjour cible et identifier les patients afin de réaliser une analyse des dossiers. 
- identifier les ISO lors d’une réhospitalisation uniquement dans l’établissement où a eu lieu la pose de PTH ou PTG.

Pour les établissements qui souhaiteraient utiliser les programmes : Il est strictement interdit d’importer sur la plateforme des données hospitalières (PDH) de l’ATIH des données individuelles issues d’un PMSI local, puis de les croiser avec les bases PMSI nationales sans une autorisation de la CNIL.

## Pour information : 
En 2024, l’ATIH a mis à disposition des établissements dans l'espace de téléchargement de l'ATIH le logiciel ALICE : Affichage Local des Informations de Correspondance des Établissements. ALICE édite un fichier contenant des informations permettant d’identifier le séjour. L’établissement peut ensuite identifier le patient. Avec ALICE, les établissements peuvent identifier les patients correspondant aux séjours détectés en 2021 (campagne 2022) avec ETE ou ISO dans l’établissement où a eu lieu la pose de prothèse totale de hanche ou de genou, et analyser les dossiers correspondants.


## Liens utiles 
Pages concernant ces indicateurs sur le site internet de la HAS 

- [IQSS 2022 - Évènements thrombo-emboliques après pose de prothèse totale de hanche (ETE-PTH)](https://www.has-sante.fr/jcms/p_3293932/fr/iqss-2021-evenements-thrombo-emboliques-apres-pose-de-prothese-totale-de-hanche-ete-pth)
- [IQSS 2022 - Évènements thrombo-emboliques après pose de prothèse totale de genou (ETE-PTG)](https://www.has-sante.fr/jcms/p_3293934/fr/iqss-2021-evenements-thrombo-emboliques-apres-pose-de-prothese-totale-de-genou-ete-ptg)
- [IQSS 2022 - Infections du site opératoire après pose de prothèse totale de hanche (ISO-PTH)](https://www.has-sante.fr/jcms/p_3294825/fr/iqss-2021-infections-du-site-operatoire-apres-pose-de-prothese-totale-de-hanche-iso-pth)
- [IQSS 2022 - Infections du site opératoire après pose de prothèse totale de genou (ISO-PTG)](https://www.has-sante.fr/jcms/p_3294826/fr/iqss-2021-infections-du-site-operatoire-apres-pose-de-prothese-totale-de-genou-iso-ptg)

## Licence et citation

Ce dépôt est partagé sous [licence EUPL](LICENCE).

Il est disponible en ligne sur les espaces [GitHub de l'ATIH](https://github.com/ATIH/SAS_indicateurs_HAS/) et [GitLab de la HAS](https://gitlab.has-sante.fr/has-sante/public/indicateurs-resultats-chirurgie-orthopedique).

Si vous utilisez ces documents et programmes, merci de citer la source en incluant la référence suivante :

> Programmes et spécifications des indicateurs de résultats en chirurgie orthopédique, HAS et ATIH, version 2022


## Contact

L’adresse contact est : data@atih.sante.fr
