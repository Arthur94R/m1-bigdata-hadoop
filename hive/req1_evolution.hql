USE accidents_moto;

INSERT OVERWRITE LOCAL DIRECTORY '/Users/arthurrondeau/data/resultats/req1_evolution'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT 
    CASE 
        WHEN c.an <= 50 THEN c.an + 2000
        ELSE c.an
    END as annee,
    COUNT(*) as nb_usagers_motos,
    SUM(CASE WHEN u.grav = 2 THEN 1 ELSE 0 END) as nb_tues,
    SUM(CASE WHEN u.grav = 3 THEN 1 ELSE 0 END) as nb_blesses_hospitalises
FROM caracteristiques c
JOIN vehicules v ON c.Num_Acc = v.Num_Acc
JOIN usagers u ON v.Num_Acc = u.Num_Acc AND v.num_veh = u.num_veh
WHERE v.catv IN (30, 31, 32, 33, 34)
  AND ((c.an >= 15 AND c.an <= 24) OR (c.an >= 2015 AND c.an <= 2024))
GROUP BY 
    CASE 
        WHEN c.an <= 50 THEN c.an + 2000
        ELSE c.an
    END
ORDER BY annee;
