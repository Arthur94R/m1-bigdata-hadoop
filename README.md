# 🏍️ Big Data — Analyse des accidents moto en France

Projet universitaire — Master 1 IA & Big Data, Université Paris 8

## 📋 Description

Analyse de **5 millions d'accidents de moto** en France sur 10 ans (2015-2024) à l'aide d'un écosystème Hadoop complet. Le projet explore les facteurs de risque : météo, heure, type de route, profil des victimes.

## 🔍 Résultats clés

- 📉 Baisse de **25%** des accidents entre 2015 et 2024
- 🌙 Conduite de nuit : taux de mortalité de **7.21%**
- 👴 Seniors (60+) : taux de mortalité de **7.06%** vs 3.19% pour les 18-24 ans
- 💥 Collisions frontales : taux de mortalité de **9%**

## 🛠️ Stack technique

- **HDFS** — Stockage distribué des 40 fichiers CSV
- **Hive** — Requêtes SQL sur les données distribuées
- **Python** — Visualisations avec Matplotlib

## 📁 Structure
```
data/           → Fichiers CSV bruts (2015-2024)
hive/           → Scripts HiveQL
src/            → Scripts Python pour visualisations
report/         → Rapport PDF du projet
```

## 🚀 Lancer le projet
```bash
# Démarrer Hadoop
start-dfs.sh
start-yarn.sh

# Charger les données dans HDFS
hdfs dfs -put data/ /accidents/

# Lancer les requêtes Hive
hive -f hive/queries.hql
```

## 📊 Données

Source : [data.gouv.fr](https://www.data.gouv.fr) — Fichiers CSV annuels des accidents corporels
