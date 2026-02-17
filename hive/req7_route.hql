USE accidents_moto;

INSERT OVERWRITE LOCAL DIRECTORY '/Users/arthurrondeau/data/resultats/req7_route'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT 
    CASE l.prof
        WHEN 1 THEN 'Plat'
        WHEN 2 THEN 'Pente'
        WHEN 3 THEN 'Sommet_de_cote'
        WHEN 4 THEN 'Bas_de_cote'
        ELSE 'Non_renseigne'
    END as profil_route,
    CASE l.plan
        WHEN 1 THEN 'Rectiligne'
        WHEN 2 THEN 'Courbe_gauche'
        WHEN 3 THEN 'Courbe_droite'
        WHEN 4 THEN 'En_S'
        ELSE 'Non_renseigne'
    END as trace_route,
    COUNT(*) as nb_victimes,
    SUM(CASE WHEN u.grav = 2 THEN 1 ELSE 0 END) as nb_tues
FROM caracteristiques c
JOIN vehicules v ON c.Num_Acc = v.Num_Acc
JOIN usagers u ON v.Num_Acc = u.Num_Acc AND v.num_veh = u.num_veh
JOIN lieux l ON c.Num_Acc = l.Num_Acc
WHERE v.catv IN (30, 31, 32, 33, 34)
  AND ((c.an >= 15 AND c.an <= 24) OR (c.an >= 2015 AND c.an <= 2024))
GROUP BY l.prof, l.plan
ORDER BY nb_victimes DESC
LIMIT 20;
