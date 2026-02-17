-- Créer la base de données
CREATE DATABASE IF NOT EXISTS accidents_moto;
USE accidents_moto;

-- TABLE 1 : CARACTERISTIQUES
DROP TABLE IF EXISTS caracteristiques;
CREATE EXTERNAL TABLE caracteristiques (
    Num_Acc STRING,
    jour INT,
    mois INT,
    an INT,
    hrmn STRING,
    lum INT,
    dep STRING,
    com STRING,
    agg INT,
    inter INT,
    atm INT,
    col INT,
    adr STRING,
    lat FLOAT,
    lon FLOAT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/data/accidents/caracteristiques/'
TBLPROPERTIES ("skip.header.line.count"="1");

-- TABLE 2 : VEHICULES
DROP TABLE IF EXISTS vehicules;
CREATE EXTERNAL TABLE vehicules (
    Num_Acc STRING,
    id_vehicule STRING,
    num_veh STRING,
    senc INT,
    catv INT,
    obs INT,
    obsm INT,
    choc INT,
    manv INT,
    motor INT,
    occutc STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/data/accidents/vehicules/'
TBLPROPERTIES ("skip.header.line.count"="1");

-- TABLE 3 : USAGERS
DROP TABLE IF EXISTS usagers;
CREATE EXTERNAL TABLE usagers (
    Num_Acc STRING,
    id_usager STRING,
    num_veh STRING,
    place INT,
    catu INT,
    grav INT,
    sexe INT,
    an_nais INT,
    trajet INT,
    secu1 INT,
    secu2 INT,
    secu3 INT,
    locp INT,
    actp STRING,
    etatp INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/data/accidents/usagers/'
TBLPROPERTIES ("skip.header.line.count"="1");

-- TABLE 4 : LIEUX
DROP TABLE IF EXISTS lieux;
CREATE EXTERNAL TABLE lieux (
    Num_Acc STRING,
    catr INT,
    voie STRING,
    v1 INT,
    v2 STRING,
    circ INT,
    nbv INT,
    vosp INT,
    prof INT,
    pr INT,
    pr1 INT,
    plan INT,
    lartpc INT,
    larrout INT,
    surf INT,
    infra INT,
    situ INT,
    vma INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/data/accidents/lieux/'
TBLPROPERTIES ("skip.header.line.count"="1");

-- Vérifications
SHOW TABLES;
SELECT COUNT(*) as nb_caracteristiques FROM caracteristiques;
SELECT COUNT(*) as nb_vehicules FROM vehicules;
SELECT COUNT(*) as nb_usagers FROM usagers;
SELECT COUNT(*) as nb_lieux FROM lieux;

-- Combien de motos ?
SELECT COUNT(*) as nb_motos 
FROM vehicules 
WHERE catv IN (30, 31, 32, 33, 34);
