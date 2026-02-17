USE accidents_moto;

INSERT OVERWRITE LOCAL DIRECTORY '/Users/arthurrondeau/data/resultats/req3_meteo'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT 
    CASE c.atm
        WHEN 1 THEN 'Normale'
        WHEN 2 THEN 'Pluie_legere'
        WHEN 3 THEN 'Pluie_forte'
        WHEN 4 THEN 'Neige_grele'
        WHEN 5 THEN 'Brouillard'
        WHEN 6 THEN 'Vent_fort'
        WHEN 7 THEN 'Temps_eblouissant'
        WHEN 8 THEN 'Temps_couvert'
        WHEN 9 THEN 'Autre'
        ELSE 'Non_renseigne'
    END as conditions_meteo,
    COUNT(*) as nb_victimes,
    SUM(CASE WHEN u.grav = 2 THEN 1 ELSE 0 END) as nb_tues,
    SUM(CASE WHEN u.grav = 3 THEN 1 ELSE 0 END) as nb_blesses_graves,
    ROUND(SUM(CASE WHEN u.grav = 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as taux_mortalite
FROM caracteristiques c
JOIN vehicules v ON c.Num_Acc = v.Num_Acc
JOIN usagers u ON v.Num_Acc = u.Num_Acc AND v.num_veh = u.num_veh
WHERE v.catv IN (30, 31, 32, 33, 34)
  AND ((c.an >= 15 AND c.an <= 24) OR (c.an >= 2015 AND c.an <= 2024))
GROUP BY c.atm
ORDER BY nb_victimes DESC;
