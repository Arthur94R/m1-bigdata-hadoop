USE accidents_moto;

INSERT OVERWRITE LOCAL DIRECTORY '/Users/arthurrondeau/data/resultats/req5_heure'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT 
    CASE 
        WHEN CAST(SUBSTRING(c.hrmn, 1, 2) AS INT) BETWEEN 0 AND 5 THEN '1_00h-06h_Nuit'
        WHEN CAST(SUBSTRING(c.hrmn, 1, 2) AS INT) BETWEEN 6 AND 11 THEN '2_06h-12h_Matin'
        WHEN CAST(SUBSTRING(c.hrmn, 1, 2) AS INT) BETWEEN 12 AND 17 THEN '3_12h-18h_Apres_midi'
        WHEN CAST(SUBSTRING(c.hrmn, 1, 2) AS INT) BETWEEN 18 AND 23 THEN '4_18h-00h_Soiree'
        ELSE '5_Non_renseigne'
    END as plage_horaire,
    COUNT(*) as nb_victimes,
    SUM(CASE WHEN u.grav = 2 THEN 1 ELSE 0 END) as nb_tues,
    ROUND(SUM(CASE WHEN u.grav = 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as taux_mortalite
FROM caracteristiques c
JOIN vehicules v ON c.Num_Acc = v.Num_Acc
JOIN usagers u ON v.Num_Acc = u.Num_Acc AND v.num_veh = u.num_veh
WHERE v.catv IN (30, 31, 32, 33, 34)
  AND ((c.an >= 15 AND c.an <= 24) OR (c.an >= 2015 AND c.an <= 2024))
GROUP BY 
    CASE 
        WHEN CAST(SUBSTRING(c.hrmn, 1, 2) AS INT) BETWEEN 0 AND 5 THEN '1_00h-06h_Nuit'
        WHEN CAST(SUBSTRING(c.hrmn, 1, 2) AS INT) BETWEEN 6 AND 11 THEN '2_06h-12h_Matin'
        WHEN CAST(SUBSTRING(c.hrmn, 1, 2) AS INT) BETWEEN 12 AND 17 THEN '3_12h-18h_Apres_midi'
        WHEN CAST(SUBSTRING(c.hrmn, 1, 2) AS INT) BETWEEN 18 AND 23 THEN '4_18h-00h_Soiree'
        ELSE '5_Non_renseigne'
    END
ORDER BY plage_horaire;
