USE accidents_moto;

INSERT OVERWRITE LOCAL DIRECTORY '/Users/arthurrondeau/data/resultats/req6_collision'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT 
    CASE c.col
        WHEN 1 THEN 'Deux_vehicules_frontale'
        WHEN 2 THEN 'Deux_vehicules_arriere'
        WHEN 3 THEN 'Deux_vehicules_cote'
        WHEN 4 THEN 'Trois_vehicules_chaine'
        WHEN 5 THEN 'Trois_vehicules_multiples'
        WHEN 6 THEN 'Autre_collision'
        WHEN 7 THEN 'Sans_collision'
        ELSE 'Non_renseigne'
    END as type_collision,
    COUNT(*) as nb_victimes,
    SUM(CASE WHEN u.grav = 2 THEN 1 ELSE 0 END) as nb_tues,
    ROUND(SUM(CASE WHEN u.grav = 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as taux_mortalite
FROM caracteristiques c
JOIN vehicules v ON c.Num_Acc = v.Num_Acc
JOIN usagers u ON v.Num_Acc = u.Num_Acc AND v.num_veh = u.num_veh
WHERE v.catv IN (30, 31, 32, 33, 34)
  AND ((c.an >= 15 AND c.an <= 24) OR (c.an >= 2015 AND c.an <= 2024))
GROUP BY c.col
ORDER BY nb_victimes DESC;
