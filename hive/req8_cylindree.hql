USE accidents_moto;

INSERT OVERWRITE LOCAL DIRECTORY '/Users/arthurrondeau/data/resultats/req8_cylindree'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT 
    CASE v.catv
        WHEN 30 THEN '1_Scooter_moins_50cc'
        WHEN 31 THEN '2_Moto_50-125cc'
        WHEN 32 THEN '3_Scooter_50-125cc'
        WHEN 33 THEN '4_Moto_plus_125cc'
        WHEN 34 THEN '5_Scooter_plus_125cc'
        ELSE '6_Autre'
    END as type_moto,
    COUNT(*) as nb_victimes,
    SUM(CASE WHEN u.grav = 2 THEN 1 ELSE 0 END) as nb_tues,
    ROUND(SUM(CASE WHEN u.grav = 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as taux_mortalite
FROM caracteristiques c
JOIN vehicules v ON c.Num_Acc = v.Num_Acc
JOIN usagers u ON v.Num_Acc = u.Num_Acc AND v.num_veh = u.num_veh
WHERE v.catv IN (30, 31, 32, 33, 34)
  AND ((c.an >= 15 AND c.an <= 24) OR (c.an >= 2015 AND c.an <= 2024))
GROUP BY v.catv
ORDER BY type_moto;
