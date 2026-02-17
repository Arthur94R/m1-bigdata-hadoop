USE accidents_moto;

INSERT OVERWRITE LOCAL DIRECTORY '/Users/arthurrondeau/data/resultats/req4_age'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT 
    CASE 
        WHEN (c.an - u.an_nais) < 18 THEN '0_Moins_de_18_ans'
        WHEN (c.an - u.an_nais) BETWEEN 18 AND 24 THEN '1_18-24_ans'
        WHEN (c.an - u.an_nais) BETWEEN 25 AND 34 THEN '2_25-34_ans'
        WHEN (c.an - u.an_nais) BETWEEN 35 AND 44 THEN '3_35-44_ans'
        WHEN (c.an - u.an_nais) BETWEEN 45 AND 54 THEN '4_45-54_ans'
        WHEN (c.an - u.an_nais) BETWEEN 55 AND 64 THEN '5_55-64_ans'
        WHEN (c.an - u.an_nais) >= 65 THEN '6_65_ans_et_plus'
        ELSE '7_Non_renseigne'
    END as tranche_age,
    COUNT(*) as nb_victimes,
    SUM(CASE WHEN u.grav = 2 THEN 1 ELSE 0 END) as nb_tues,
    SUM(CASE WHEN u.grav = 3 THEN 1 ELSE 0 END) as nb_blesses_graves,
    ROUND(SUM(CASE WHEN u.grav = 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as taux_mortalite
FROM caracteristiques c
JOIN vehicules v ON c.Num_Acc = v.Num_Acc
JOIN usagers u ON v.Num_Acc = u.Num_Acc AND v.num_veh = u.num_veh
WHERE v.catv IN (30, 31, 32, 33, 34)
  AND ((c.an >= 15 AND c.an <= 24) OR (c.an >= 2015 AND c.an <= 2024))
GROUP BY 
    CASE 
        WHEN (c.an - u.an_nais) < 18 THEN '0_Moins_de_18_ans'
        WHEN (c.an - u.an_nais) BETWEEN 18 AND 24 THEN '1_18-24_ans'
        WHEN (c.an - u.an_nais) BETWEEN 25 AND 34 THEN '2_25-34_ans'
        WHEN (c.an - u.an_nais) BETWEEN 35 AND 44 THEN '3_35-44_ans'
        WHEN (c.an - u.an_nais) BETWEEN 45 AND 54 THEN '4_45-54_ans'
        WHEN (c.an - u.an_nais) BETWEEN 55 AND 64 THEN '5_55-64_ans'
        WHEN (c.an - u.an_nais) >= 65 THEN '6_65_ans_et_plus'
        ELSE '7_Non_renseigne'
    END
ORDER BY tranche_age;
