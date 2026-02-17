import pandas as pd
import matplotlib.pyplot as plt
import os

# Configuration style
plt.style.use('seaborn-v0_8-darkgrid')
output_dir = 'graphiques'
os.makedirs(output_dir, exist_ok=True)

# ========== GRAPHIQUE 1 : Évolution 2015-2024 ==========
df1 = pd.read_csv('resultats/req1_evolution/000000_0', 
                  names=['annee', 'nb_victimes', 'nb_tues', 'nb_hospitalises'])

fig, ax = plt.subplots(figsize=(10, 6))
ax.plot(df1['annee'], df1['nb_victimes'], marker='o', linewidth=2, label='Victimes totales')
ax.plot(df1['annee'], df1['nb_tues'], marker='s', linewidth=2, label='Tués', color='red')
ax.set_xlabel('Année', fontsize=12)
ax.set_ylabel('Nombre', fontsize=12)
ax.set_title('Évolution des accidents de moto (2015-2024)', fontsize=14, fontweight='bold')
ax.legend()
ax.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig(f'{output_dir}/1_evolution.png', dpi=300, bbox_inches='tight')
print("✅ Graphique 1 : Évolution")

# ========== GRAPHIQUE 2 : Top 10 départements ==========
df2 = pd.read_csv('resultats/req2_departements/000000_0', 
                  names=['departement', 'nb_victimes', 'nb_tues', 'taux_mortalite'],
                  dtype={'departement': str})  # Forcer en string
# Filtrer les départements vides et prendre le top 10
df2_clean = df2[df2['departement'].notna() & (df2['departement'] != '')].head(10)

fig, ax = plt.subplots(figsize=(12, 8))
ax.barh(df2_clean['departement'], df2_clean['nb_victimes'], color='steelblue')
ax.set_xlabel('Nombre de victimes', fontsize=12)
ax.set_ylabel('Département', fontsize=12)
ax.set_title('Top 10 départements - Accidents de moto (2015-2024)', fontsize=14, fontweight='bold')
ax.invert_yaxis()
ax.grid(True, alpha=0.3, axis='x')
# Ajouter les valeurs sur les barres
for i, v in enumerate(df2_clean['nb_victimes']):
    ax.text(v + 200, i, f'{int(v):,}', va='center', fontsize=10)
plt.tight_layout()
plt.savefig(f'{output_dir}/2_departements.png', dpi=300, bbox_inches='tight')
print("✅ Graphique 2 : Départements")

# ========== GRAPHIQUE 3 : Météo (top 8) ==========
df3 = pd.read_csv('resultats/req3_meteo/000000_0', 
                  names=['meteo', 'nb_victimes', 'nb_tues', 'nb_blesses', 'taux_mortalite'])
df3_clean = df3[df3['meteo'] != 'Non_renseigne'].head(8)

fig, ax = plt.subplots(figsize=(10, 6))
bars = ax.bar(range(len(df3_clean)), df3_clean['taux_mortalite'], color='coral')
ax.set_xticks(range(len(df3_clean)))
ax.set_xticklabels(df3_clean['meteo'], rotation=45, ha='right')
ax.set_ylabel('Taux de mortalité (%)', fontsize=12)
ax.set_title('Taux de mortalité selon les conditions météo', fontsize=14, fontweight='bold')
ax.grid(True, alpha=0.3, axis='y')
plt.tight_layout()
plt.savefig(f'{output_dir}/3_meteo.png', dpi=300, bbox_inches='tight')
print("✅ Graphique 3 : Météo")

# ========== GRAPHIQUE 4 : Profils par âge ==========
df4 = pd.read_csv('resultats/req4_age/000000_0', 
                  names=['tranche_age', 'nb_victimes', 'nb_tues', 'nb_blesses', 'taux_mortalite'])
df4_clean = df4[df4['tranche_age'] != '7_Non_renseigne']
df4_clean['age_label'] = df4_clean['tranche_age'].str.replace(r'^\d_', '', regex=True)

fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))

# Sous-graphique 1 : Nombre de victimes
ax1.bar(df4_clean['age_label'], df4_clean['nb_victimes'], color='skyblue')
ax1.set_xlabel('Tranche d\'âge', fontsize=11)
ax1.set_ylabel('Nombre de victimes', fontsize=11)
ax1.set_title('Victimes par tranche d\'âge', fontsize=12, fontweight='bold')
ax1.tick_params(axis='x', rotation=45)
ax1.grid(True, alpha=0.3, axis='y')

# Sous-graphique 2 : Taux de mortalité
ax2.plot(df4_clean['age_label'], df4_clean['taux_mortalite'], 
         marker='o', linewidth=2, color='red')
ax2.set_xlabel('Tranche d\'âge', fontsize=11)
ax2.set_ylabel('Taux de mortalité (%)', fontsize=11)
ax2.set_title('Taux de mortalité par tranche d\'âge', fontsize=12, fontweight='bold')
ax2.tick_params(axis='x', rotation=45)
ax2.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig(f'{output_dir}/4_age.png', dpi=300, bbox_inches='tight')
print("✅ Graphique 4 : Âge")

# ========== GRAPHIQUE 5 : Heures ==========
df5 = pd.read_csv('resultats/req5_heure/000000_0', 
                  names=['plage_horaire', 'nb_victimes', 'nb_tues', 'taux_mortalite'])
df5_clean = df5[df5['plage_horaire'] != '5_Non_renseigne']
df5_clean['heure_label'] = df5_clean['plage_horaire'].str.replace(r'^\d_', '', regex=True)

fig, ax = plt.subplots(figsize=(10, 6))
colors = ['#2c3e50', '#3498db', '#e74c3c', '#f39c12']
ax.bar(df5_clean['heure_label'], df5_clean['nb_victimes'], color=colors)
ax.set_xlabel('Plage horaire', fontsize=12)
ax.set_ylabel('Nombre de victimes', fontsize=12)
ax.set_title('Répartition des accidents par plage horaire', fontsize=14, fontweight='bold')
ax.grid(True, alpha=0.3, axis='y')
plt.tight_layout()
plt.savefig(f'{output_dir}/5_heure.png', dpi=300, bbox_inches='tight')
print("✅ Graphique 5 : Heures")

# ========== GRAPHIQUE 6 : Collisions (top 7) ==========
df6 = pd.read_csv('resultats/req6_collision/000000_0', 
                  names=['type_collision', 'nb_victimes', 'nb_tues', 'taux_mortalite'])
df6_clean = df6[df6['type_collision'] != 'Non_renseigne'].head(7)

fig, ax = plt.subplots(figsize=(10, 6))
bars = ax.barh(df6_clean['type_collision'], df6_clean['taux_mortalite'])
for i, bar in enumerate(bars):
    bar.set_color('red' if df6_clean.iloc[i]['taux_mortalite'] > 5 else 'steelblue')
ax.set_xlabel('Taux de mortalité (%)', fontsize=12)
ax.set_ylabel('Type de collision', fontsize=12)
ax.set_title('Taux de mortalité par type de collision', fontsize=14, fontweight='bold')
ax.invert_yaxis()
ax.grid(True, alpha=0.3, axis='x')
plt.tight_layout()
plt.savefig(f'{output_dir}/6_collision.png', dpi=300, bbox_inches='tight')
print("✅ Graphique 6 : Collisions")

# ========== GRAPHIQUE 7 : Conditions de route (top 10) ==========
df7 = pd.read_csv('resultats/req7_route/000000_0', 
                  names=['profil_route', 'trace_route', 'nb_victimes', 'nb_tues'])
df7['condition'] = df7['profil_route'] + ' + ' + df7['trace_route']
df7_top10 = df7.head(10)

fig, ax = plt.subplots(figsize=(12, 6))
ax.barh(df7_top10['condition'], df7_top10['nb_victimes'], color='green', alpha=0.7)
ax.set_xlabel('Nombre de victimes', fontsize=12)
ax.set_ylabel('Conditions de route', fontsize=12)
ax.set_title('Top 10 configurations routières - Accidents de moto', fontsize=14, fontweight='bold')
ax.invert_yaxis()
ax.grid(True, alpha=0.3, axis='x')
plt.tight_layout()
plt.savefig(f'{output_dir}/7_route.png', dpi=300, bbox_inches='tight')
print("✅ Graphique 7 : Conditions de route")

# ========== GRAPHIQUE 8 : Cylindrées ==========
df8 = pd.read_csv('resultats/req8_cylindree/000000_0', 
                  names=['type_moto', 'nb_victimes', 'nb_tues', 'taux_mortalite'])
df8['moto_label'] = df8['type_moto'].str.replace(r'^\d_', '', regex=True)

fig, ax = plt.subplots(figsize=(10, 6))
x = range(len(df8))
width = 0.35
ax.bar([i - width/2 for i in x], df8['nb_victimes']/1000, width, label='Victimes (milliers)', color='skyblue')
ax2 = ax.twinx()
ax2.plot(x, df8['taux_mortalite'], 'ro-', linewidth=2, markersize=8, label='Taux mortalité (%)')
ax.set_xlabel('Type de moto', fontsize=12)
ax.set_ylabel('Nombre de victimes (milliers)', fontsize=12)
ax2.set_ylabel('Taux de mortalité (%)', fontsize=12, color='red')
ax.set_title('Victimes et mortalité par type de moto', fontsize=14, fontweight='bold')
ax.set_xticks(x)
ax.set_xticklabels(df8['moto_label'], rotation=45, ha='right')
ax.legend(loc='upper left')
ax2.legend(loc='upper right')
ax.grid(True, alpha=0.3, axis='y')
plt.tight_layout()
plt.savefig(f'{output_dir}/8_cylindree.png', dpi=300, bbox_inches='tight')
print("✅ Graphique 8 : Cylindrées")

print("\n🎉 TOUS LES 8 GRAPHIQUES SONT CRÉÉS !")
print(f"📁 Dossier : {output_dir}/")