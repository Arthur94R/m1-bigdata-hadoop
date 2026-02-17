# 🏍️ Big Data — Analyse des accidents moto en France

Projet universitaire — Master 1 IA & Big Data, Université Paris 8

## 📋 Description

Analyse de **5 millions d'accidents de moto** en France sur 10 ans (2015-2024) à l'aide 
d'un écosystème Hadoop complet. Le projet explore les facteurs de risque : météo, heure, 
type de route, profil des victimes.

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
data/           → Dossier à remplir avec les CSV (voir ci-dessous)
hive/           → Scripts HiveQL (création tables + 8 requêtes)
src/            → Scripts Python pour visualisations
results/        → Graphiques générés
report/         → Rapport PDF du projet
```

## 📥 Récupérer les données

Les fichiers CSV ne sont pas inclus dans ce repo car trop volumineux (40 fichiers).

1. Va sur [data.gouv.fr](https://www.data.gouv.fr/fr/datasets/bases-de-donnees-annuelles-des-accidents-corporels-de-la-circulation-routiere-annees-de-2005-a-2023/)
2. Télécharge les fichiers pour chaque année de **2015 à 2024**
3. Pour chaque année tu auras 4 fichiers : `caract`, `lieux`, `usagers`, `vehicules`
4. Place tous les CSV dans le dossier `data/`

## 🚀 Lancer le projet
```bash
# Démarrer Hadoop
start-dfs.sh
start-yarn.sh

# Charger les données dans HDFS
hdfs dfs -mkdir -p /accidents
hdfs dfs -put data/ /accidents/

# Créer les tables Hive
hive -f hive/create_tables.hql
hive -f hive/fix_all_tables.hql

# Lancer les 8 requêtes d'analyse
hive -f hive/req1_evolution.hql
hive -f hive/req2_top_departements.hql
hive -f hive/req3_meteo.hql
hive -f hive/req4_age.hql
hive -f hive/req5_heure.hql
hive -f hive/req6_collision.hql
hive -f hive/req7_route.hql
hive -f hive/req8_cylindree.hql

# Générer les visualisations
python src/create_graphs.py
```
