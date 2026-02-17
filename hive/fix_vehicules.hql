USE accidents_moto;

-- Supprimer et recréer la table vehicules avec le bon séparateur
DROP TABLE IF EXISTS vehicules;
CREATE EXTERNAL TABLE vehicules (
    Num_Acc STRING,
    senc INT,
    catv INT,
    occutc STRING,
    obs INT,
    obsm INT,
    choc INT,
    manv INT,
    num_veh STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/data/accidents/vehicules/'
TBLPROPERTIES ("skip.header.line.count"="1");

-- Vérifier
SELECT COUNT(*) as nb_vehicules FROM vehicules;

-- Combien de motos ?
SELECT COUNT(*) as nb_motos 
FROM vehicules 
WHERE catv IN (30, 31, 32, 33, 34);
