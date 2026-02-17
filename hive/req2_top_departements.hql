USE accidents_moto;

INSERT OVERWRITE LOCAL DIRECTORY '/Users/arthurrondeau/data/resultats/req2_departements'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT 
    c.dep as departement,
    COUNT(*) as nb_victimes,
    SUM(CASE WHEN u.grav = 2 THEN 1 ELSE 0 END) as nb_tues,
    ROUND(SUM(CASE WHEN u.grav = 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as taux_mortalite
FROM caracteristiques c
JOIN vehicules v ON c.Num_Acc = v.Num_Acc
JOIN usagers u ON v.Num_Acc = u.Num_Acc AND v.num_veh = u.num_veh
WHERE v.catv IN (30, 31, 32, 33, 34)
  AND ((c.an >= 15 AND c.an <= 24) OR (c.an >= 2015 AND c.an <= 2024))
GROUP BY c.dep
ORDER BY nb_victimes DESC
LIMIT 20;
